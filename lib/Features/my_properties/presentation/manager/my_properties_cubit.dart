import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';

import '../../data/repos/my_properties_repo.dart';

part 'my_properties_state.dart';
class MyPropertiesCubit extends Cubit<MyPropertiesState> {
  MyPropertiesRepo myPropertiesRepo;

  MyPropertiesCubit({required this.myPropertiesRepo})
      : super(MyPropertiesInitial()) {
    _loadInitialData();
  }


  MyPropertiesResponse? _cachedResponse;
  String selectedFilter = 'All Properties';

  String get _filterValue {
    switch (selectedFilter) {
      case 'Apartments':
        return 'apartments';
      case 'Rooms':
        return 'rooms';
      default:
        return 'all';
    }
  }
  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(MyPropertiesSuccess(response: _cachedResponse!));
    } else {
      await getMyProperties();
    }
  }

  Future<void> getMyProperties({
    String? filter,
    int? page = 1,
    int? pageSize = 10,
  }) async {
    emit(MyPropertiesLoading());
    var response = await myPropertiesRepo.getMyProperties(
      filter: filter,
      page: page,
      pageSize: pageSize,
    );
    response.fold(
          (failure) => emit(MyPropertiesFailure(errMessage: failure.errMessage)),
          (resp) {
        if (resp.isSuccess == true) {
          emit(MyPropertiesSuccess(response: resp));
        } else {
          emit(
            MyPropertiesFailure(
              errMessage: resp.message ?? 'something went wrong',
            ),
          );
        }
      },
    );
  }

  Future<void> fetchPage(int pageKey, PagingController<int, Properties> pagingController) async {
    log(
        '🔍 fetchPage called - selectedFilter: $selectedFilter, _filterValue: $_filterValue');

    final response = await myPropertiesRepo.getMyProperties(
      filter: _filterValue,
      page: pageKey,
      pageSize: 10,
    );

    response.fold(
          (failure) {
        pagingController.error = failure.errMessage;
      },
          (resp) {
        if (resp.isSuccess == true) {
          final items = resp.data?.properties ?? [];
          final isLastPage = items.length < 10;

          if (isLastPage) {
            pagingController.appendLastPage(items);
          } else {
            pagingController.appendPage(items, pageKey + 1);
          }

          emit(MyPropertiesSuccess(response: resp));
        } else {
          pagingController.error = resp.message ?? 'Something went wrong';
        }
      },
    );
  }

  Future<void> deleteProperty(int id) async {
    emit(MyPropertiesLoading());
    var response = await myPropertiesRepo.deleteProperty(id: id);

    response.fold(
          (failure) => emit(MyPropertiesFailure(errMessage: failure.errMessage)),
          (_) => emit(MyPropertiesDeleteSuccess(
        deletedId: id,
        successMessage: "Property deleted successfully",
      )),
    );
  }}