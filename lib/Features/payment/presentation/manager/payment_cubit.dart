import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/payment/data/models/booking_details_response.dart';
import 'package:stay_match/Features/payment/data/models/redirect_payment_response.dart';
import 'package:stay_match/Features/payment/data/repos/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;

  PaymentCubit({required this.paymentRepo}) : super(PaymentInitial());

  Future<void> fetchBookingDetails({required int bookingId}) async {
    emit(BookingDetailsLoading());

    final result = await paymentRepo.bookingDetails(id: bookingId);

    result.fold(
          (failure) => emit(BookingDetailsFailure(errMessage: failure.errMessage)),
          (response) {
        if (response.isSuccess == true && response.data != null) {
          emit(BookingDetailsSuccess(booking: response));
        } else {
          emit(BookingDetailsFailure(
              errMessage: response.message ?? 'Failed to load booking details'));
        }
      },
    );
  }

  Future<void> getRedirectLink({
    required int bookingId,
    String paymentMethod = 'Card',
  }) async {
    final currentState = state;
    if (currentState is! BookingDetailsSuccess) return;

    emit(currentState.copyWith(
      redirectStatus: RedirectLinkStatus.loading,
      redirectError: null,
    ));

    final result = await paymentRepo.getRedirectLink(
      bookingId: bookingId,
      paymentMethod: paymentMethod,
    );

    result.fold(
          (failure) {
        final latest = state;
        if (latest is BookingDetailsSuccess) {
          emit(latest.copyWith(
            redirectStatus: RedirectLinkStatus.failure,
            redirectError: failure.errMessage,
          ));
        }
      },
          (response) {
        final latest = state;
        if (latest is BookingDetailsSuccess) {
          if (response.redirectUrl != null && response.redirectUrl!.isNotEmpty) {
            emit(latest.copyWith(
              redirectStatus: RedirectLinkStatus.success,
              redirectUrl: response.redirectUrl,
            ));
          } else {
            emit(latest.copyWith(
              redirectStatus: RedirectLinkStatus.failure,
              redirectError: 'No payment link returned',
            ));
          }
        }
      },
    );
  }
  Future<void> checkIfPaid({required int bookingId}) async {
    emit(CheckPaidLoading());
    final result = await paymentRepo.checkPaid(bookingId: bookingId);
    result.fold(
          (failure) => emit(CheckPaidFailure(failure.errMessage)),
          (response) => emit(CheckPaidSuccess(isCompleted: response.data?.isCompleted ?? false)),
    );
  }
}