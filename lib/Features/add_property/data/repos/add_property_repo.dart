import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/add_property/data/models/upload_image_response.dart';
import 'package:stay_match/core/errors/failures.dart';

import '../models/add_apartment_request.dart';
import '../models/add_apartment_response.dart';
import '../models/add_room_request.dart';
import '../models/add_room_response.dart';

abstract class AddPropertyRepo {


  Future<Either<Failure, AddApartmentResponse>> addApartment({
    required AddApartmentRequest request,
  });
  Future<Either<Failure, AddRoomResponse>> addRoom({
    required AddRoomRequest request,
  });
  Future<Either<Failure, UploadImageResponse>> uploadPropertyImg({
    required String file,
    required bool isCover
  });
}