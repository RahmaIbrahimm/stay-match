import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/payment/data/models/booking_details_response.dart';
import 'package:stay_match/Features/payment/data/models/redirect_payment_response.dart';
import 'package:stay_match/Features/payment/data/repos/payment_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';

class PaymentRepoImpl extends PaymentRepo {
  final ApiService apiService;

  PaymentRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, RedirectPaymentResponse>> getRedirectLink({
    required int bookingId,
    required String paymentMethod,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.paymentRedirectLink,
        queryParameters: {
          'bookingId': bookingId,
          'paymentMethod': paymentMethod,
        },
      );
      return right(RedirectPaymentResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, BookingDetailsResponse>> bookingDetails({required int id}) async{
    try {
      var response = await apiService.get(
        Endpoints.bookingDetails(id),
      );
      return right(BookingDetailsResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}