import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_requests_response.dart';
import 'package:stay_match/Features/booking/data/model/approve_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/decline_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/delete_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/host_requests_response.dart';
import 'package:stay_match/Features/booking/data/model/renter_bookings_response.dart';
import 'package:stay_match/Features/booking/data/model/renter_cancel_booking_response.dart';
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

  @override
  Future<Either<Failure, HostRequestsResponse>> toHostRequests(
      {String? status, String? sortBy, int? page, int? pageSize}) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.get(
        Endpoints.hostBookingRequests,
        queryParameters: {
          'status': status,
          'sortBy': sortBy,
          'page': page,
          'pageSize': pageSize,
        },);

      return Right(HostRequestsResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, RenterBookingResponse>> renterBookingRequests(
      {String? status, String? location, int? year, int? month, int? day, int? page, int? pageSize}) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.get(
        Endpoints.renterBookingRequests,
        queryParameters: {
          'status': status,
          'location': location,
          'year': year,
          'month': month,
          'day': day,
          'page': page,
          'pageSize': pageSize,
        },);

      return Right(RenterBookingResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ApproveBookingRequestResponse>> approveBookingRequest(
      {required int id}) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.put(
        Endpoints.approveBookingRequests(id),
        );

      return Right(ApproveBookingRequestResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, DeclineBookingRequestResponse>> declineBookingRequest(
      {required int id}) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.put(
        Endpoints.declineBookingRequests(id),);

      return Right(DeclineBookingRequestResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, RenterCancelBookingResponse>> renterCancelBooking(
      {required int id}) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.put(
        Endpoints.renterCancelBookingRequests(id),
      );

      return Right(RenterCancelBookingResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, DeleteBookingRequestResponse>> deleteBookingRequest({required int id})async {
    try {
      final response = await apiService.delete(
        Endpoints.deleteBookingRequests(id),
      );

      return Right(DeleteBookingRequestResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }  }

}