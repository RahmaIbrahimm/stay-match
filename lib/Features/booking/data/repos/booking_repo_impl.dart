import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/room_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import '../model/room_booking_request_response.dart';

class BookingRepoImpl extends BookingRepo {
  ApiService apiService;

  BookingRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ApartmentBookingRequestResponse>>
  requestApartmentBooking({required ApartmentBookingRequestRequest request}) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.post(
        Endpoints.requestApartmentBooking,
        data: request.toJson(),
      );

      return Right(ApartmentBookingRequestResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, RoomBookingRequestResponse>> requestRoomBooking({
    required RoomBookingRequestRequest request,
  }) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.post(
        Endpoints.requestRoomBooking,
        data: request.toJson(),
      );

      return Right(RoomBookingRequestResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }
}