
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/model/host_requests_response.dart';
import 'package:stay_match/Features/booking/data/model/renter_bookings_response.dart';
import 'package:stay_match/Features/booking/data/model/room_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';

import 'booking_request_state.dart';


enum UserType {
  host,
  renter
}
enum BookingPropertyType {
  privateRoom,
  entireApartment,
}
class BookingRequestCubit extends Cubit<BookingRequestState> {
  final BookingRepo bookingRepo;
  final PropertyType? propertyType;

  BookingRequestCubit({required this.bookingRepo, this.propertyType})
      : super(BookingRequestInitial()) {
    // ─── Setup Listeners For Infinite Scroll Pagination ───
    hostPagingController.addPageRequestListener((pageKey) {
      fetchHostBookingRequestsPage(pageKey);
    });

    renterPagingController.addPageRequestListener((pageKey) {
      fetchRenterBookingRequestsPage(pageKey);
    });
  }

  String currentSortKey = 'newest'; // 'newest' or 'oldest'
  String currentFilterKey = 'all';
  int deletedBookingId = -1;
  int canceledBookingId = -1;
  bool isFiltered = false;
  int? lastProcessedId;
  // ─── ORIGINAL FIELDS ───
  ApartmentBookingRequestRequest _apartmentRequest = ApartmentBookingRequestRequest(
    duration: null,
    message: null,
    propertyId: null,
    startDate: null,
  );
  RoomBookingRequestRequest _roomRequest = RoomBookingRequestRequest(
      duration: null,
      message: null,
      propertyId: null,
      startDate: null,
      roomId: null
  );

  // ─── PAGINATION CONTROLLERS ───
  final PagingController<int, Requests> hostPagingController = PagingController(
      firstPageKey: 1);
  final PagingController<int,
      dynamic> renterPagingController = PagingController(
      firstPageKey: 1);

  // ─── HOST STATE VARIABLES ───
  HostRequestsResponse? hostLatestResponseData;

  // ─── RENTER STATE VARIABLES ───
  String currentRenterFilterKey = 'all';
  RenterBookingResponse? renterLatestResponseData;
  String renterSearchLocation = '';
  int? renterSelectedYear;
  int? renterSelectedMonth;
  int? renterSelectedDay;

  // ─── ORIGINAL LOGIC METHODS ───
  void updateBookingData({
    int? duration,
    int? propertyId,
    int? roomId,
    String? startDate,
    String? message,
     BookingPropertyType type = BookingPropertyType.entireApartment
  }) {
   if(type == BookingPropertyType.entireApartment){
     _apartmentRequest = ApartmentBookingRequestRequest(
       duration: duration ?? _apartmentRequest.duration,
       propertyId: propertyId ?? _apartmentRequest.propertyId,
       startDate: startDate ?? _apartmentRequest.startDate,
       message: message ?? _apartmentRequest.message,
     );
   }
   else{
     _roomRequest = RoomBookingRequestRequest(
       duration: duration ?? _apartmentRequest.duration,
       propertyId: propertyId ?? _apartmentRequest.propertyId,
       startDate: startDate ?? _apartmentRequest.startDate,
       message: message ?? _apartmentRequest.message,
       roomId: roomId ??_roomRequest.roomId
     );

   }
  }

  ApartmentBookingRequestRequest get apartmentRequest => _apartmentRequest;

  Future<void> sendApartmentBooking() async {
    if (_apartmentRequest.propertyId == null || _apartmentRequest.startDate == null) {
      emit(BookingRequestFailure(
          errMessage: "Missing required booking details"));
      return;
    }

    emit(BookingRequestLoading());

    final result = await bookingRepo.requestApartmentBooking(
      request: _apartmentRequest,
    );

    result.fold(
          (failure) {
        debugPrint("Cubit: Emitting Failure");
        emit(BookingRequestFailure(errMessage: failure.errMessage));
      },
          (response) {
        if (response.isSuccess == true) {
          debugPrint("Cubit: Emitting Success");
          emit(BookingRequestSuccess());
        } else {
          emit(BookingRequestFailure(errMessage: response.message ?? "Failed"));
        }
      },
    );
  }

  Future<void> sendRoomBooking() async {
    if (_roomRequest.propertyId == null ||
        _roomRequest.startDate == null || _roomRequest.roomId == null) {
      emit(BookingRequestFailure(
          errMessage: "Missing required booking details"));
      return;
    }

    emit(BookingRequestLoading());

    final result = await bookingRepo.requestRoomBooking(
      request: _roomRequest,
    );

    result.fold(
          (failure) {
        debugPrint("Cubit: Emitting Failure");
        emit(BookingRequestFailure(errMessage: failure.errMessage));
      },
          (response) {
        if (response.isSuccess == true) {
          debugPrint("Cubit: Emitting Success");
          emit(BookingRequestSuccess());
        } else {
          emit(BookingRequestFailure(errMessage: response.message ?? "Failed"));
        }
      },
    );
  }

  // ─── HOST PAGINATION TRACKING LOGIC ───
  Future<void> fetchHostBookingRequestsPage(int pageKey) async {
    final result = await bookingRepo.toHostRequests(
      page: pageKey,
      pageSize: 10,
      status: currentFilterKey == 'all' ? null : currentFilterKey,
      sortBy: currentSortKey,
    );

    result.fold(
          (failure) {
            hostPagingController.error = failure.errMessage;
        emit(BookingRequestFailure(errMessage: failure.errMessage));
      },
          (response) {
        if (response.isSuccess == true) {
          hostLatestResponseData = response;
          final fetchedItems = response.data?.requests ?? [];

          final isLastPage = fetchedItems.length < 10 ||
              response.data?.pagination?.hasNext == false;

          if (isLastPage) {
            hostPagingController.appendLastPage(fetchedItems);
          } else {
            hostPagingController.appendPage(fetchedItems, pageKey + 1);
          }

          emit(BookingRequestSuccess(hostRequestsResponse: response));
        } else {
          final errMsg = response.message ?? "Failed to fetch bookings";
          hostPagingController.error = errMsg;
          emit(BookingRequestFailure(errMessage: errMsg));
        }
      },
    );
  }

  void refreshBookingList() {
    hostPagingController.refresh();
  }

  // ─── RENTER PAGINATION TRACKING LOGIC ───
  Future<void> fetchRenterBookingRequestsPage(int pageKey) async {
    final result = await bookingRepo.renterBookingRequests(
      page: pageKey,
      pageSize: 10,
      status: currentRenterFilterKey == 'all' ? null : currentRenterFilterKey,
      location: renterSearchLocation.isEmpty ? null : renterSearchLocation,
      year: renterSelectedYear,
      month: renterSelectedMonth,
      day: renterSelectedDay,
    );

    result.fold(
          (failure) {
            renterPagingController.error = failure.errMessage;
        emit(BookingRequestFailure(errMessage: failure.errMessage));
      },
          (response) {
        if (response.isSuccess == true) {
          renterLatestResponseData = response;
          final fetchedItems = response.data?.bookings ?? [];

          final isLastPage = fetchedItems.length < 10 ||
              response.data?.pagination?.hasNext == false;

          if (isLastPage) {
            renterPagingController.appendLastPage(fetchedItems);
          } else {
            renterPagingController.appendPage(fetchedItems, pageKey + 1);
          }

          emit(BookingRequestSuccess(renterBookingResponse: response));
        } else {
          final errMsg = response.message ?? "Failed to fetch bookings";
          renterPagingController.error = errMsg;
          emit(BookingRequestFailure(errMessage: errMsg));
        }
      },
    );
  }

  void changeRenterFilterTab(String tabKey) {
    currentRenterFilterKey = tabKey;
    renterPagingController.refresh();
  }

  void updateRenterSearch(String locationQuery) {
    renterSearchLocation = locationQuery;
    renterPagingController.refresh();
  }

  void applyRenterDateFilters({int? year, int? month, int? day}) {
    renterSelectedYear = year;
    renterSelectedMonth = month;
    renterSelectedDay = day;
    isFiltered = (year != null || month != null || day != null) ? true : false ;
    log("isFiltered: $isFiltered",name: "Filtered?");
    renterPagingController.refresh();
  }

  void clearRenterDateFilters() {
    renterSelectedYear = null;
    renterSelectedMonth = null;
    renterSelectedDay = null;
    renterPagingController.refresh();
  }

  void refreshRenterBookingList() {
    renterPagingController.refresh();
  }

  void toggleSort() {
    // Toggle between 'newest' and 'oldest'
    final newSort = currentSortKey == 'newest' ? 'oldest' : 'newest';
    currentSortKey = newSort;

    // Refresh the list with the new sort key
    hostPagingController.refresh();
  }

  void changeActiveFilterTab(String key, UserType type) {
    currentFilterKey = key;
    // Refresh the list with the new filter
    if (type == UserType.host) {
      hostPagingController.refresh();
    } else {
      renterPagingController.refresh();
    }
  }

  Future<void> renterCancelBooking(int id) async {
    var response = await bookingRepo.renterCancelBooking(id: id);
    response.fold((fail) =>
        emit(BookingRequestFailure(errMessage: fail.errMessage)), (resp) {
      if (resp.isSuccess == true) {
        // Remove the cancelled booking from the renter's paged list
        final currentItems = List<dynamic>.from(
            renterPagingController.itemList ?? []);
        currentItems.removeWhere((item) => item.id == id);
        renterPagingController.itemList = currentItems;

        emit(BookingRequestSuccess(cancelBooking: resp,successMessage: "Booking cancelled successfully."));
      } else {
        emit(BookingRequestFailure(errMessage: "Booking cancellation failed. Please try again."));
      }
    });
  }
  Future<void> approveBooking(int id) async {
    lastProcessedId = id;
    var response = await bookingRepo.approveBookingRequest(id: id);
    response.fold((fail) =>
        emit(BookingRequestFailure(errMessage: fail.errMessage)), (resp) {
      if (resp.isSuccess == true) {
        emit(BookingRequestSuccess(approveBooking: resp,successMessage: "Booking approved successfully."));
        final currentItems = List<Requests>.from(hostPagingController.itemList ?? []);
        currentItems.removeWhere((item) => item.id == id);
        hostPagingController.itemList = currentItems;
      } else {
        emit(BookingRequestFailure(errMessage:"Booking approval failed. Please try again."));
      }
    });
  }

  Future<void> declineBooking(int id) async {
    lastProcessedId = id;
    var response = await bookingRepo.declineBookingRequest(id: id);
    response.fold((fail) =>
        emit(BookingRequestFailure(errMessage: fail.errMessage)), (resp) {
      if (resp.isSuccess == true) {
        emit(BookingRequestSuccess(declineBooking: resp,successMessage: "Booking declined successfully."));
        final currentItems = List<Requests>.from(hostPagingController.itemList ?? []);
        currentItems.removeWhere((item) => item.id == id);
        hostPagingController.itemList = currentItems;
      } else {
        emit(BookingRequestFailure(errMessage:"Booking decline failed. Please try again."));
      }
    });
  }

  Future<void> deleteBooking(int id) async {
    var response = await bookingRepo.deleteBookingRequest(id: id);
    response.fold((fail) =>
        emit(BookingRequestFailure(errMessage: fail.errMessage)), (resp) {
      if (resp.isSuccess == true) {
        final currentItems = List<Requests>.from(hostPagingController.itemList ?? []);
        currentItems.removeWhere((item) => item.id == id);
        hostPagingController.itemList = currentItems;
        emit(BookingRequestSuccess(deleteBooking: resp,successMessage: "Booking deleted successfully."));
      } else {
        emit(BookingRequestFailure(errMessage: "Booking deletion Unsuccessful, Please try again later."));
      }
    });
  }


  // ─── DISPOSE ───
  @override
  Future<void> close() {
    hostPagingController.dispose();
    renterPagingController.dispose();
    return super.close();
  }
}