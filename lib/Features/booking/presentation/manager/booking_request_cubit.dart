import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';

part 'booking_request_state.dart';

class BookingRequestCubit extends Cubit<BookingRequestState> {
  final BookingRepo bookingRepo;
  final PropertyType propertyType;

  BookingRequestCubit(this.bookingRepo, {required this.propertyType})
      : super(BookingRequestInitial());

  ApartmentBookingRequestRequest _apartmentRequest = ApartmentBookingRequestRequest(
  duration: null,
  message: null,
  propertyId: null,
  startDate: null
  );


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
    // Optional: emit an 'Updated' state if you want the UI to react to changes
  }

  ApartmentBookingRequestRequest get apartmentRequest => _apartmentRequest;

  // Future<void> sendApartmentBooking(ApartmentBookingRequestRequest request) async {
  Future<void> sendApartmentBooking() async {
    // Basic validation before emitting loading
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
  }}