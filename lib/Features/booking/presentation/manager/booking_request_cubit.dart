// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
// import 'package:stay_match/Features/booking/data/model/my_bookings_response.dart';
// import 'package:stay_match/Features/booking/data/repos/booking_repo.dart';
// import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';
//
// part 'booking_request_state.dart';
//
// class BookingRequestCubit extends Cubit<BookingRequestState> {
//   final BookingRepo bookingRepo;
//   final PropertyType propertyType;
//
//   BookingRequestCubit(this.bookingRepo, {required this.propertyType})
//       : super(BookingRequestInitial());
//
//   ApartmentBookingRequestRequest _apartmentRequest = ApartmentBookingRequestRequest(
//   duration: null,
//   message: null,
//   propertyId: null,
//   startDate: null
//   );
//
//
//   void updateBookingData({
//     int? duration,
//     int? propertyId,
//     String? startDate,
//     String? message,
//   }) {
//     _apartmentRequest = ApartmentBookingRequestRequest(
//       duration: duration ?? _apartmentRequest.duration,
//       propertyId: propertyId ?? _apartmentRequest.propertyId,
//       startDate: startDate ?? _apartmentRequest.startDate,
//       message: message ?? _apartmentRequest.message,
//     );
//     // Optional: emit an 'Updated' state if you want the UI to react to changes
//   }
//
//   ApartmentBookingRequestRequest get apartmentRequest => _apartmentRequest;
//
//   // Future<void> sendApartmentBooking(ApartmentBookingRequestRequest request) async {
//   Future<void> sendApartmentBooking() async {
//     // Basic validation before emitting loading
//     if (_apartmentRequest.propertyId == null || _apartmentRequest.startDate == null) {
//       emit(const BookingRequestFailure(errMessage: "Missing required booking details"));
//       return;
//     }
//
//     emit(BookingRequestLoading());
//
//     final result = await bookingRepo.requestApartmentBooking(
//       request: _apartmentRequest,
//     );
//
//     result.fold(
//           (failure) {
//         debugPrint("Cubit: Emitting Failure");
//         emit(BookingRequestFailure(errMessage: failure.errMessage));
//       },
//           (response) {
//         if (response.isSuccess == true) {
//           debugPrint("Cubit: Emitting Success");
//           emit(BookingRequestSuccess());
//         } else {
//           emit(BookingRequestFailure(errMessage: response.message ?? "Failed"));
//         }
//       },
//     );
//   }
//
//
// }

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/model/my_bookings_response.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';

part 'booking_request_state.dart';

class BookingRequestCubit extends Cubit<BookingRequestState> {
  final BookingRepo bookingRepo;
  final PropertyType? propertyType;

  BookingRequestCubit(this.bookingRepo, {this.propertyType})
      : super(BookingRequestInitial()) {
    // ─── ADDED: Setup listener for infinite scroll ───
    pagingController.addPageRequestListener((pageKey) {
      fetchBookingRequestsPage(pageKey);
    });
  }

  // ─── ORIGINAL FIELDS (UNTOUCHED) ───
  ApartmentBookingRequestRequest _apartmentRequest = ApartmentBookingRequestRequest(
    duration: null,
    message: null,
    propertyId: null,
    startDate: null,
  );

  // ─── ADDED: Pagination Specific Variables ───
  final PagingController<int, Bookings> pagingController = PagingController(firstPageKey: 1);
  String currentFilterKey = 'all';
  MyBookingsResponse? latestResponseData;

  // ─── ORIGINAL LOGIC METHODS (UNTOUCHED) ───
  void updateBookingData({
    int? duration,
    int? propertyId,
    String? startDate,
    String? message,
  }) {
    _apartmentRequest = ApartmentBookingRequestRequest(
      duration: duration ?? _apartmentRequest.duration,
      propertyId: propertyId ?? _apartmentRequest.propertyId,
      startDate: startDate ?? _apartmentRequest.startDate,
      message: message ?? _apartmentRequest.message,
    );
  }

  ApartmentBookingRequestRequest get apartmentRequest => _apartmentRequest;

  Future<void> sendApartmentBooking() async {
    if (_apartmentRequest.propertyId == null || _apartmentRequest.startDate == null) {
      emit(const BookingRequestFailure(errMessage: "Missing required booking details"));
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

  Future<void> getBookingRequests() async {
    if (_apartmentRequest.propertyId == null || _apartmentRequest.startDate == null) {
      emit(const BookingRequestFailure(errMessage: "Missing required booking details"));
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

  // ─── ADDED: New Independent Pagination Tracking Logic ───
  Future<void> fetchBookingRequestsPage(int pageKey) async {
    final result = await bookingRepo.myBookingRequests(
      page: pageKey,
      pageSize: 10,
    );

    result.fold(
          (failure) {
        pagingController.error = failure.errMessage;
        // Make sure to use an explicit error state that doesn't conflict with your standard workflow
        emit(BookingRequestFailure(errMessage: failure.errMessage));
      },
          (response) {
        if (response.isSuccess == true) {
          latestResponseData = response;
          final fetchedItems = response.data?.bookings ?? [];

          final isLastPage = fetchedItems.length < 10 ||
              response.data?.pagination?.hasNext == false;

          if (isLastPage) {
            pagingController.appendLastPage(fetchedItems);
          } else {
            pagingController.appendPage(fetchedItems, pageKey + 1);
          }

          emit(BookingRequestSuccess(response: response));
        } else {
          final errMsg = response.message ?? "Failed to fetch bookings";
          pagingController.error = errMsg;
          emit(BookingRequestFailure(errMessage: errMsg));
        }
      },
    );
  }

  void changeActiveFilterTab(String tabKey) {
    currentFilterKey = tabKey;
    pagingController.refresh();
  }

  void refreshBookingList() {
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}