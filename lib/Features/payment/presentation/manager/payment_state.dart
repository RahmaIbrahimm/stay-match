part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class BookingDetailsLoading extends PaymentState {}

class BookingDetailsFailure extends PaymentState {
  final String errMessage;

  const BookingDetailsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

/// Emitted once booking details are loaded. [redirectStatus] tracks the
/// separate "Pay Now" button flow so the UI can show a loading/error state
/// on the button without losing the already-loaded booking summary.
class BookingDetailsSuccess extends PaymentState {
  final BookingDetailsResponse booking;
  final RedirectLinkStatus redirectStatus;
  final String? redirectUrl;
  final String? redirectError;

  const BookingDetailsSuccess({
    required this.booking,
    this.redirectStatus = RedirectLinkStatus.initial,
    this.redirectUrl,
    this.redirectError,
  });

  BookingDetailsSuccess copyWith({
    BookingDetailsResponse? booking,
    RedirectLinkStatus? redirectStatus,
    String? redirectUrl,
    String? redirectError,
  }) {
    return BookingDetailsSuccess(
      booking: booking ?? this.booking,
      redirectStatus: redirectStatus ?? this.redirectStatus,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      redirectError: redirectError ?? this.redirectError,
    );
  }

  @override
  List<Object?> get props => [booking, redirectStatus, redirectUrl, redirectError];
}

enum RedirectLinkStatus { initial, loading, success, failure }