import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_request.dart';
import 'package:stay_match/Features/booking/data/model/apartment_booking_request_response.dart';
import 'package:stay_match/Features/booking/data/model/room_booking_request_request.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../model/room_booking_request_response.dart';

abstract class BookingRepo {
  Future<Either<Failure, ApartmentBookingRequestResponse>> requestApartmentBooking({
    required ApartmentBookingRequestRequest request
  });

  Future<Either<Failure, RoomBookingRequestResponse>> requestRoomBooking({
    required RoomBookingRequestRequest request

  });
}