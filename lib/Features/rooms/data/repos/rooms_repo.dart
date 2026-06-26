import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/apartments/data/models/property_details_response.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/get_all_rooms.dart';

abstract class RoomsRepo {
  Future<Either<Failure, GetAllRooms>> getAllRooms({
    String? start,
    num? monthsCount,
    String? government,
    bool? allowsFamilies,
    bool? allowsChildren,
    bool? allowsStudents,
    bool? allowsWorkers,
    String? studentGender,
    String? workerGender,
    double? userLat,
    double? userLng,
    bool orderByOldest = false,
    bool onlyAvailable = false,
    num? page,
    num? pageSize,
  });
  Future<Either<Failure, RoomDetailsResponse>> getRoomDetails({
    required int roomid ,  required int propertyId
  });
  Future<Either<Failure, SharedApartmentDetails>> getSharedPropertyDetails({
    required int id,
  });
  Future<Either<Failure, PropertyDetailsResponse>> getPropertyDetails({
    required int id,
  });
}