import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_requests_response.dart';
import 'package:stay_match/Features/booking/data/model/approve_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/decline_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/host_requests_response.dart';
import 'package:stay_match/Features/booking/data/model/renter_bookings_response.dart';
import 'package:stay_match/Features/booking/data/model/renter_cancel_booking_response.dart';
import 'package:stay_match/Features/booking/data/model/room_booking_request_request.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../model/room_booking_request_response.dart';
import '../model/delete_booking_request_response.dart';

abstract class BookingRepo {
  Future<Either<Failure, ApartmentBookingRequestResponse>> requestApartmentBooking({
    required ApartmentBookingRequestRequest request
  });

  Future<Either<Failure, RoomBookingRequestResponse>> requestRoomBooking({
    required RoomBookingRequestRequest request

  });

  Future<Either<Failure, HostRequestsResponse>> toHostRequests(
      {String? status, String? sortBy, int? page, int? pageSize});

  Future<Either<Failure, RenterBookingResponse>> renterBookingRequests({
    String? status,
    String? location,
    int? year,
    int? month,
    int? day,
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, RenterCancelBookingResponse>> renterCancelBooking({
    required int id,
  });

  Future<Either<Failure, ApproveBookingRequestResponse>> approveBookingRequest({
    required int id,
  });

  Future<Either<Failure, DeclineBookingRequestResponse>> declineBookingRequest({
    required int id,
  });  Future<Either<Failure, DeleteBookingRequestResponse>> deleteBookingRequest({
    required int id,
  });

}