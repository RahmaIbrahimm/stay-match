import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/apartments/data/repos/apartment_repo.dart';
import 'package:stay_match/Features/rooms/data/models/get_all_rooms.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../core/utils/secure_storage_helper.dart';
import '../../../apartments/data/models/all_apartments_response.dart';
import '../../data/models/apartment_filter_params.dart';
import '../../data/models/location_model.dart';
import '../../data/models/rooms_filter_params.dart';
import 'location_cubit.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final ApartmentRepo apartmentRepo;
  final RoomsRepo roomsRepo;

  // Apartment filter state
  ApartmentFilterParams _currentApartmentFilters =
      const ApartmentFilterParams();
  ApartmentFilterParams? _lastAppliedApartmentFilters;
  AllApartmentsResponse? _apartmentCachedResponse;

  // Rooms filter state
  RoomsFilterParams _currentRoomsFilters = const RoomsFilterParams();
  RoomsFilterParams? _lastAppliedRoomsFilters;
  GetAllRooms? _roomsCachedResponse;

  FilterCubit({required this.roomsRepo, required this.apartmentRepo})
    : super(FilterInitial()) {
    log('FilterCubit initialized');
  }

  // Getters for UI
  ApartmentFilterParams get currentApartmentFilters => _currentApartmentFilters;
  RoomsFilterParams get currentRoomsFilters => _currentRoomsFilters;

  // Apartment Methods
  Future<void> updateApartmentFilter({
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? studentGender,
    String? workerGender,
    double? userLat,
    double? userLng,
    bool? orderByOldest,
    bool? onlyAvailable,
    num? page,
    num? pageSize,
    bool forceRefresh = false,
  }) async {
    if (start != null) log('🏢 Apartment | start: $start');
    if (monthsCount != null) log('🏢 Apartment | monthsCount: $monthsCount');
    if (government != null) log('🏢 Apartment | government: $government');
    if (allowsFamilies != null)
      log('🏢 Apartment | allowsFamilies: $allowsFamilies');
    if (allowsChildren != null)
      log('🏢 Apartment | allowsChildren: $allowsChildren');
    if (allowsStudents != null)
      log('🏢 Apartment | allowsStudents: $allowsStudents');
    if (allowsWorkers != null)
      log('🏢 Apartment | allowsWorkers: $allowsWorkers');
    if (studentGender != null)
      log('🏢 Apartment | studentGender: $studentGender');
    if (workerGender != null) log('🏢 Apartment | workerGender: $workerGender');
    if (userLat != null) log('🏢 Apartment | userLat: $userLat');
    if (userLng != null) log('🏢 Apartment | userLng: $userLng');
    if (orderByOldest != null)
      log('🏢 Apartment | orderByOldest: $orderByOldest');
    if (onlyAvailable != null)
      log('🏢 Apartment | onlyAvailable: $onlyAvailable');
    if (page != null) log('🏢 Apartment | page: $page');
    if (pageSize != null) log('🏢 Apartment | pageSize: $pageSize');
    _currentApartmentFilters = _currentApartmentFilters.copyWith(
      start: start,
      monthsCount: monthsCount,
      government: government,
      allowsFamilies: allowsFamilies,
      allowsChildren: allowsChildren,
      allowsStudents: allowsStudents,
      allowsWorkers: allowsWorkers,
      studentGender: studentGender,
      workerGender: workerGender,
      userLat: userLat,
      userLng: userLng,
      orderByOldest: orderByOldest,
      onlyAvailable: onlyAvailable,
      page: page,
      pageSize: pageSize,
    );

    final bool filtersChanged =
        _lastAppliedApartmentFilters == null ||
        _currentApartmentFilters.hasChanges(_lastAppliedApartmentFilters);

    await _getAllApartmentsWithFilters(
      forceRefresh: forceRefresh || filtersChanged,
    );
  }

  Future<void> toggleApartmentSortOrder() async {
    log(
      'Toggling apartment sort order from ${_currentApartmentFilters.orderByOldest} to ${!_currentApartmentFilters.orderByOldest}',
    );
    await updateApartmentFilter(
      orderByOldest: !_currentApartmentFilters.orderByOldest,
      forceRefresh: true,
    );
  }

  // location update
  Future<void> updateApartmentLocation({
    required Governorate? government,
    required City? city,
  }) async {
    log(
      '📍 apartment location updated: ${city?.nameInEnglish} (lat: ${city?.latitude}, lng: ${city?.longitude})',
    );
    await updateApartmentFilter(
      government: government?.nameInEnglish,
      userLat: city?.latitude,
      userLng: city?.longitude,
      forceRefresh: true,
    );
  }

  Future<void> _getAllApartmentsWithFilters({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _apartmentCachedResponse != null &&
        _lastAppliedApartmentFilters != null &&
        !_currentApartmentFilters.hasChanges(_lastAppliedApartmentFilters)) {
      log('Using cached apartments response with same filters');
      emit(ApartmentFilterSuccess(response: _apartmentCachedResponse!));
      return;
    }

    emit(ApartmentFilterLoading());

    try {
      var response = await apartmentRepo.getAllApartments(
        start: _currentApartmentFilters.start,
        monthsCount: _currentApartmentFilters.monthsCount,
        government: _currentApartmentFilters.government,
        allowsFamilies: _currentApartmentFilters.allowsFamilies,
        allowsChildren: _currentApartmentFilters.allowsChildren,
        allowsStudents: _currentApartmentFilters.allowsStudents,
        allowsWorkers: _currentApartmentFilters.allowsWorkers,
        studentGender: _currentApartmentFilters.studentGender,
        workerGender: _currentApartmentFilters.workerGender,
        userLat: _currentApartmentFilters.userLat,
        userLng: _currentApartmentFilters.userLng,
        orderByOldest: _currentApartmentFilters.orderByOldest,
        onlyAvailable: _currentApartmentFilters.onlyAvailable,
        page: _currentApartmentFilters.page,
        pageSize: _currentApartmentFilters.pageSize,
      );

      response.fold(
        (fail) {
          log('Apartment API failure: ${fail.errMessage}');
          emit(ApartmentFilterFailure(errMessage: fail.errMessage));
        },
        (response) {
          if (response.isSuccess == true) {
            _apartmentCachedResponse = response;
            _lastAppliedApartmentFilters = _currentApartmentFilters;
            log(
              'Emitting ApartmentFilterSuccess with ${response.data?.items?.length ?? 0} items',
            );
            emit(ApartmentFilterSuccess(response: response));
          } else {
            log('Apartment API returned isSuccess=false: ${response.message}');
            emit(
              ApartmentFilterFailure(
                errMessage: response.message ?? 'Error getting Apartments',
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      log(
        'Exception in getAllApartments: $e',
        error: e,
        stackTrace: stackTrace,
      );
      emit(ApartmentFilterFailure(errMessage: e.toString()));
    }
  }

  Future<void> getAllApartments({bool forceRefresh = false}) async {
    await _getAllApartmentsWithFilters(forceRefresh: forceRefresh);
  }

  Future<void> resetApartmentFilters() async {
    log('Resetting all apartment filters');
    _currentApartmentFilters = const ApartmentFilterParams();
    await _getAllApartmentsWithFilters(forceRefresh: true);
  }

  // Rooms Methods
  Future<void> updateRoomsFilter({
    String? start,
    int? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? workerGender,
    String? studentGender,
    double? userLat,
    double? userLng,
    bool? orderByOldest,
    bool? onlyAvailable,
    num? page,
    num? pageSize,
    bool forceRefresh = false,
  }) async {
    // Add this at the beginning of updateRoomsFilter method
    if (start != null) log('🚪 Rooms | start: $start');
    if (monthsCount != null) log('🚪 Rooms | monthsCount: $monthsCount');
    if (government != null) log('🚪 Rooms | government: $government');
    if (allowsFamilies != null)
      log('🚪 Rooms | allowsFamilies: $allowsFamilies');
    if (allowsChildren != null)
      log('🚪 Rooms | allowsChildren: $allowsChildren');
    if (allowsStudents != null)
      log('🚪 Rooms | allowsStudents: $allowsStudents');
    if (allowsWorkers != null) log('🚪 Rooms | allowsWorkers: $allowsWorkers');
    if (workerGender != null) log('🚪 Rooms | workerGender: $workerGender');
    if (studentGender != null) log('🚪 Rooms | studentGender: $studentGender');
    if (userLat != null) log('🚪 Rooms | userLat: $userLat');
    if (userLng != null) log('🚪 Rooms | userLng: $userLng');
    if (orderByOldest != null) log('🚪 Rooms | orderByOldest: $orderByOldest');
    if (onlyAvailable != null) log('🚪 Rooms | onlyAvailable: $onlyAvailable');
    if (page != null) log('🚪 Rooms | page: $page');
    if (pageSize != null) log('🚪 Rooms | pageSize: $pageSize');
    _currentRoomsFilters = _currentRoomsFilters.copyWith(
      start: start,
      monthsCount: monthsCount,
      government: government,
      allowsFamilies: allowsFamilies,
      allowsChildren: allowsChildren,
      allowsStudents: allowsStudents,
      allowsWorkers: allowsWorkers,
      workerGender: workerGender,
      studentGender: studentGender,
      userLat: userLat,
      userLng: userLng,
      orderByOldest: orderByOldest,
      onlyAvailable: onlyAvailable,
      page: page,
      pageSize: pageSize,
    );

    final bool filtersChanged =
        _lastAppliedRoomsFilters == null ||
        _currentRoomsFilters.hasChanges(_lastAppliedRoomsFilters);

    await _getAllRoomsWithFilters(forceRefresh: forceRefresh || filtersChanged);
  }

  Future<void> updateRoomsLocation({
    required Governorate? government,
    required City? city,
  }) async {
    log(
      '📍 Rooms location updated: ${city?.nameInEnglish} (lat: ${city?.latitude}, lng: ${city?.longitude})',
    );
    await updateRoomsFilter(
      government: government?.nameInEnglish,
      userLat: city?.latitude,
      userLng: city?.longitude,
      forceRefresh: true,
    );
  }

  Future<void> toggleRoomsSortOrder() async {
    log(
      'Toggling rooms sort order from ${_currentRoomsFilters.orderByOldest} to ${!_currentRoomsFilters.orderByOldest}',
    );
    await updateRoomsFilter(
      orderByOldest: !_currentRoomsFilters.orderByOldest,
      forceRefresh: true,
    );
  }

  Future<void> _getAllRoomsWithFilters({bool forceRefresh = false}) async {
    log(
      'Getting rooms with filters: orderByOldest=${_currentRoomsFilters.orderByOldest}, '
      'government=${_currentRoomsFilters.government}, '
      'page=${_currentRoomsFilters.page}',
    );

    if (!forceRefresh &&
        _roomsCachedResponse != null &&
        _lastAppliedRoomsFilters != null &&
        !_currentRoomsFilters.hasChanges(_lastAppliedRoomsFilters)) {
      log('Using cached rooms response with same filters');
      emit(RoomsFilterSuccess(response: _roomsCachedResponse!));
      return;
    }

    emit(RoomsFilterLoading());

    try {
      final secureStorage = getIt.get<SecureStorageHelper>();
      final token = await secureStorage.readFromSecureStorage(key:SecureStorageKeys.refreshTokenKey );
      log(
        'Token before rooms request: ${token != null ? 'Token present (${token.length} chars)' : 'NO TOKEN'}',
      );

      var response = await roomsRepo.getAllRooms(
        start: _currentRoomsFilters.start,
        monthsCount: _currentRoomsFilters.monthsCount,
        government: _currentRoomsFilters.government,
        allowsFamilies: _currentRoomsFilters.allowsFamilies,
        allowsChildren: _currentRoomsFilters.allowsChildren,
        allowsStudents: _currentRoomsFilters.allowsStudents,
        allowsWorkers: _currentRoomsFilters.allowsWorkers,
        workerGender: _currentRoomsFilters.workerGender,
        studentGender: _currentRoomsFilters.studentGender,
        userLat: _currentRoomsFilters.userLat,
        userLng: _currentRoomsFilters.userLng,
        orderByOldest: _currentRoomsFilters.orderByOldest,
        onlyAvailable: _currentRoomsFilters.onlyAvailable,
        page: _currentRoomsFilters.page,
        pageSize: _currentRoomsFilters.pageSize,
      );

      response.fold(
        (fail) {
          log('Rooms API failure: ${fail.errMessage}');
          emit(RoomsFilterFailure(errMessage: fail.errMessage));
        },
        (response) async {
          final secureStorage = getIt.get<SecureStorageHelper>();
          final token = await secureStorage.readFromSecureStorage(key:SecureStorageKeys.refreshTokenKey );
          log(
            'Token after rooms request: ${token != null ? 'Token present (${token.length} chars)' : 'NO TOKEN'}',
          );

          if (response.isSuccess == true) {
            _roomsCachedResponse = response;
            _lastAppliedRoomsFilters = _currentRoomsFilters;
            log(
              'Emitting RoomsFilterSuccess with ${response.data?.items?.length ?? 0} rooms',
            );
            emit(RoomsFilterSuccess(response: response));
          } else {
            log('Rooms API returned isSuccess=false: ${response.message}');
            emit(
              RoomsFilterFailure(
                errMessage: response.message ?? 'Error Filtering Rooms',
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      log('Exception in getAllRooms: $e', error: e, stackTrace: stackTrace);
      emit(RoomsFilterFailure(errMessage: e.toString()));
    }
  }

  Future<void> getAllRooms({bool forceRefresh = false}) async {
    await _getAllRoomsWithFilters(forceRefresh: forceRefresh);
  }

  Future<void> resetRoomsFilters() async {
    log('Resetting all rooms filters');
    _currentRoomsFilters = const RoomsFilterParams();
    await _getAllRoomsWithFilters(forceRefresh: true);
  }
// --- ADDED FOR PAGINATION ---
  Future<void> fetchRoomsPage(int pageKey, PagingController<int, Items> pagingController) async {
    // Note: We use the current filters but override the page with pageKey
    final response = await roomsRepo.getAllRooms(
      start: _currentRoomsFilters.start,
      monthsCount: _currentRoomsFilters.monthsCount,
      government: _currentRoomsFilters.government,
      allowsFamilies: _currentRoomsFilters.allowsFamilies,
      allowsChildren: _currentRoomsFilters.allowsChildren,
      allowsStudents: _currentRoomsFilters.allowsStudents,
      allowsWorkers: _currentRoomsFilters.allowsWorkers,
      workerGender: _currentRoomsFilters.workerGender,
      studentGender: _currentRoomsFilters.studentGender,
      userLat: _currentRoomsFilters.userLat,
      userLng: _currentRoomsFilters.userLng,
      orderByOldest: _currentRoomsFilters.orderByOldest,
      onlyAvailable: _currentRoomsFilters.onlyAvailable,
      page: pageKey, // The controller provides the current page index
      pageSize: 10,
    );

    response.fold(
          (fail) {
        log('Pagination Error: ${fail.errMessage}');
        pagingController.error = fail.errMessage;
      },
          (resp) {
        if (resp.isSuccess == true) {
          final items = resp.data?.items ?? [];
          final isLastPage = items.length < 10;

          if (isLastPage) {
            pagingController.appendLastPage(items);
          } else {
            pagingController.appendPage(items, pageKey + 1);
          }

          // Optional: Sync the success state so other UI elements
          // (like result counts) stay updated
          _roomsCachedResponse = resp;
          emit(RoomsFilterSuccess(response: resp));
        } else {
          pagingController.error = resp.message ?? 'Error fetching rooms';
        }
      },
    );
  }
  // Clear all caches
  void clearCache() {
    log('Clearing all caches');
    _apartmentCachedResponse = null;
    _roomsCachedResponse = null;
    _lastAppliedApartmentFilters = null;
    _lastAppliedRoomsFilters = null;
  }





  // =========================================================================
// 🏢 ADDED FOR ISOLATED APARTMENT PAGINATION (Leaves everything else untouched)
// =========================================================================

  // 1. Isolated controller bound to your AllApartmentsItems model type
  final PagingController<int, AllApartmentsItems> apartmentPagingController =
  PagingController(firstPageKey: 1);

  // 2. Setup a helper function to link UI listeners to your cubit safely
  void initApartmentPagination() {
    // Clear previous listeners to avoid duplicate firing cycles if called again
    apartmentPagingController.removePageRequestListener(_apartmentPageListener);
    apartmentPagingController.addPageRequestListener(_apartmentPageListener);
  }

  void _apartmentPageListener(int pageKey) {
    fetchApartmentsPage(pageKey);
  }

  // 3. Isolated paginated fetcher that respects your running filter variables
  Future<void> fetchApartmentsPage(int pageKey) async {
    log('🏢 Fetching paginated apartments page: $pageKey');

    var response = await apartmentRepo.getAllApartments(
      start: _currentApartmentFilters.start,
      monthsCount: _currentApartmentFilters.monthsCount,
      government: _currentApartmentFilters.government,
      allowsFamilies: _currentApartmentFilters.allowsFamilies,
      allowsChildren: _currentApartmentFilters.allowsChildren,
      allowsStudents: _currentApartmentFilters.allowsStudents,
      allowsWorkers: _currentApartmentFilters.allowsWorkers,
      studentGender: _currentApartmentFilters.studentGender,
      workerGender: _currentApartmentFilters.workerGender,
      userLat: _currentApartmentFilters.userLat,
      userLng: _currentApartmentFilters.userLng,
      orderByOldest: _currentApartmentFilters.orderByOldest,
      onlyAvailable: _currentApartmentFilters.onlyAvailable,
      page: pageKey,
      pageSize: 10, // Retaining your established page size configuration
    );

    response.fold(
          (fail) {
        log('🏢 Paginated Apartment Error: ${fail.errMessage}');
        apartmentPagingController.error = fail.errMessage;
      },
          (resp) {
        if (resp.isSuccess == true) {
          final items = resp.data?.items ?? [];
          final hasMore = resp.data?.hasNext ?? false;

          if (!hasMore) {
            apartmentPagingController.appendLastPage(items);
          } else {
            apartmentPagingController.appendPage(items, pageKey + 1);
          }

          // Keep your cache background variables synchronized cleanly
          _apartmentCachedResponse = resp;
          _lastAppliedApartmentFilters = _currentApartmentFilters;
        } else {
          apartmentPagingController.error = resp.message ?? 'Error fetching apartments';
        }
      },
    );
  }

  // 4. Clean up addition inside your existing close() or clear functions if desired
  void refreshApartmentPagination() {
    apartmentPagingController.refresh();
  }
}