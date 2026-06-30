
import 'package:equatable/equatable.dart';

import '../../data/model/approve_booking_request_response.dart';
import '../../data/model/decline_booking_request_response.dart';
import '../../data/model/delete_booking_request_response.dart';
import '../../data/model/host_requests_response.dart';
import '../../data/model/renter_bookings_response.dart';
import '../../data/model/renter_cancel_booking_response.dart';

sealed class BookingRequestState extends Equatable {
  const BookingRequestState();

  @override
  List<Object?> get props => [];
}

final class BookingRequestInitial extends BookingRequestState {}

final class BookingRequestLoading extends BookingRequestState {}

final class BookingRequestSuccess extends BookingRequestState {
  final HostRequestsResponse? hostRequestsResponse;
  final RenterBookingResponse? renterBookingResponse;
  final DeleteBookingRequestResponse? deleteBooking;
  final DeclineBookingRequestResponse? declineBooking;
  final ApproveBookingRequestResponse? approveBooking;
  final RenterCancelBookingResponse? cancelBooking;
  final String? successMessage;
  const BookingRequestSuccess({
    this.hostRequestsResponse,
    this.renterBookingResponse,
    this.deleteBooking,
    this.declineBooking,
    this.approveBooking,
    this.cancelBooking, this.successMessage,
  });

  @override
  List<Object?> get props => [
    hostRequestsResponse,
    renterBookingResponse,
    deleteBooking,
    declineBooking,
    approveBooking,
    cancelBooking,
    successMessage,
  ];
}

final class BookingRequestFailure extends BookingRequestState {
  final String errMessage;

  // A monotonically increasing id so that two failures with the *same*
  // errMessage are still treated as distinct states by Equatable.
  // Without this, Bloc's emit() is a no-op when the new state == current
  // state, so BlocListener never fires for a second identical failure.
  final int _instanceId;

  BookingRequestFailure({required this.errMessage})
      : _instanceId = DateTime.now().microsecondsSinceEpoch;

  @override
  List<Object?> get props => [errMessage, _instanceId];
}