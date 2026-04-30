part of 'booking_request_cubit.dart';

// booking_request_state.dart
sealed class BookingRequestState extends Equatable {
  const BookingRequestState();
  @override
  List<Object?> get props => [];
}

final class BookingRequestInitial extends BookingRequestState {
  @override
  List<Object?> get props => [];
}
final class BookingRequestLoading extends BookingRequestState {
  @override
  List<Object?> get props => [];
}
final class BookingRequestSuccess extends BookingRequestState {
  @override
  List<Object?> get props => [];
}
final class BookingRequestFailure extends BookingRequestState {
  final String errMessage;
  const BookingRequestFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}