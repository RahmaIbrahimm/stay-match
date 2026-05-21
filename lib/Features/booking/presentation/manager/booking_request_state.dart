part of 'booking_request_cubit.dart';

sealed class BookingRequestState extends Equatable {
  const BookingRequestState();
  @override
  List<Object?> get props => [];
}
final class BookingRequestInitial extends BookingRequestState {}
final class BookingRequestLoading extends BookingRequestState {}
final class BookingRequestSuccess extends BookingRequestState {
  final MyBookingsResponse? response; // Optional field so it doesn't break old invocations

  const BookingRequestSuccess({this.response});

  @override
  List<Object?> get props => [response];
}
final class BookingRequestFailure extends BookingRequestState {
  final String errMessage;

  const BookingRequestFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}


// final class MyBookingRequestLoading extends BookingRequestState {
//   @override
//   List<Object?> get props => [];
// }
// final class MyBookingRequestSuccess extends BookingRequestState {
//   final MyBookingsResponse response;
//
//   const MyBookingRequestSuccess({required this.response});
//
//   @override
//   List<Object?> get props => [];
// }
// final class MyBookingRequestFailure extends BookingRequestState {
//   final String errMessage;
//
//   const MyBookingRequestFailure({required this.errMessage});
//
//   @override
//   List<Object?> get props => [];
// }