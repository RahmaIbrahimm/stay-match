import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/payment/data/models/check_if_paid_response.dart';
import 'package:stay_match/Features/payment/data/models/redirect_payment_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/booking_details_response.dart';

abstract class PaymentRepo {
  Future<Either<Failure,RedirectPaymentResponse>> getRedirectLink({required int bookingId,required String paymentMethod});
  Future<Either<Failure,BookingDetailsResponse>> bookingDetails({required int id});
  Future<Either<Failure,CheckIfPaidResponse>> checkPaid({required int bookingId });
}