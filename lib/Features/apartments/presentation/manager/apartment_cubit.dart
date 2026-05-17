import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/models/all_apartments.dart';
import '../../data/repos/apartment_repo.dart';

part 'apartment_state.dart';

class ApartmentCubit extends Cubit<ApartmentsState> {
  final ApartmentRepo apartmentRepo; // Marked final for best practice

  ApartmentCubit(this.apartmentRepo) : super(ApartmentsInitial()) {
    _loadInitialData();

    // 1. ONLY initialized here. Leaves all other workflows completely untouched.
    pagingController.addPageRequestListener((pageKey) {
      getPaginatedApartments(page: pageKey);
    });
  }

  AllApartmentsResponse? _cachedResponse;

  // ── 2. NEW PAGINATION CONTROLLER (Isolated) ───────────────────────────────
  final PagingController<int, AllApartmentsItems> pagingController =
  PagingController(firstPageKey: 1);

  Map<String, dynamic> _paginationFilters = {};
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(GetApartmentsSuccess(response: _cachedResponse!));
    } else {
      await getAllApartments();
    }
  }

  // ── 3. NEW SEPARATE PAGINATION METHOD (Leaves getAllApartments 100% untouched) ──
  Future<void> getPaginatedApartments({
    num? page = 1,
    num? pageSize = 3,
    bool changingFilters = false,
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    String? workerGender,
    double? userLat,
    double? userLng,
    bool orderByOldest = false,
    bool onlyAvailable = false,
  }) async {
    // If the view layer explicitly tells us filters changed, track them separately
    if (page == 1 && changingFilters) {
      _paginationFilters = {
        'start': start,
        'monthsCount': monthsCount,
        'government': government,
        'allowsFamilies': allowsFamilies,
        'allowsChildren': allowsChildren,
        'allowsStudents': allowsStudents,
        'workerGender': workerGender,
        'userLat': userLat,
        'userLng': userLng,
        'orderByOldest': orderByOldest,
        'onlyAvailable': onlyAvailable,
      };
    }

    try {
      var response = await apartmentRepo.getAllApartments(
        start: page == 1 && changingFilters ? start : _paginationFilters['start'],
        monthsCount: page == 1 && changingFilters ? monthsCount : _paginationFilters['monthsCount'],
        government: page == 1 && changingFilters ? government : _paginationFilters['government'],
        allowsFamilies: page == 1 && changingFilters ? allowsFamilies : _paginationFilters['allowsFamilies'],
        allowsChildren: page == 1 && changingFilters ? allowsChildren : _paginationFilters['allowsChildren'],
        allowsStudents: page == 1 && changingFilters ? allowsStudents : _paginationFilters['allowsStudents'],
        workerGender: page == 1 && changingFilters ? workerGender : _paginationFilters['workerGender'],
        userLat: page == 1 && changingFilters ? userLat : _paginationFilters['userLat'],
        userLng: page == 1 && changingFilters ? userLng : _paginationFilters['userLng'],
        orderByOldest: page == 1 && changingFilters ? orderByOldest : _paginationFilters['orderByOldest'],
        onlyAvailable: page == 1 && changingFilters ? onlyAvailable : _paginationFilters['onlyAvailable'],
        page: page,
        pageSize: pageSize,
      );

      response.fold(
            (fail) => pagingController.error = fail.errMessage,
            (resp) {
          if (resp.isSuccess == true) {
            final items = resp.data?.items ?? [];
            final hasMore = resp.data?.hasNext ?? false;

            if (!hasMore) {
              pagingController.appendLastPage(items);
            } else {
              final nextPageKey = (page as int) + 1;
              pagingController.appendPage(items, nextPageKey);
            }
          } else {
            pagingController.error = resp.message ?? 'Error getting Apartments';
          }
        },
      );
    } catch (e) {
      pagingController.error = e.toString();
    }
  }

  // ── 4. NEW SEPARATE REFRESH FOR PAGINATION SCREEN ─────────────────────────
  void refreshPaginationScreen() {
    pagingController.refresh();
  }

  // ── 5. ORIGINAL METHOD (UNTOUCHED) ────────────────────────────────────────
  Future<void> getAllApartments({
    bool forceRefresh = false,
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    String? workerGender,
    double? userLat,
    double? userLng,
    bool orderByOldest = false,
    bool onlyAvailable = false,
    num? page = 1,
    num? pageSize = 3,
  }) async {
    if (!forceRefresh && _cachedResponse != null) {
      emit(GetApartmentsSuccess(response: _cachedResponse!));
      return;
    }

    emit(GetApartmentsLoading());

    try {
      var response = await apartmentRepo.getAllApartments(
        start: start,
        monthsCount: monthsCount,
        government: government,
        allowsFamilies: allowsFamilies,
        allowsChildren: allowsChildren,
        allowsStudents: allowsStudents,
        workerGender: workerGender,
        userLat: userLat,
        userLng: userLng,
        orderByOldest: orderByOldest,
        onlyAvailable: onlyAvailable,
        page: page,
        pageSize: pageSize,
      );

      response.fold(
            (fail) {
          emit(GetApartmentsFailure(errMessage: fail.errMessage));
        },
            (response) {
          if (response.isSuccess == true) {
            _cachedResponse = response;
            emit(GetApartmentsSuccess(response: response));
          } else {
            emit(
              GetApartmentsFailure(
                errMessage: response.message ?? 'Error getting Apartments',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(GetApartmentsFailure(errMessage: e.toString()));
    }
  }

  // ── 6. ORIGINAL METHOD (UNTOUCHED) ────────────────────────────────────────
  Future<void> refreshApartments() async {
    await getAllApartments(forceRefresh: true);
  }

  @override
  Future<void> close() {
    pagingController.dispose(); // Cleans up controller resources safely
    return super.close();
  }
}