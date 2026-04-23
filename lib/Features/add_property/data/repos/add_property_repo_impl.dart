import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/add_property/data/models/upload_image_response.dart';
import 'package:http_parser/http_parser.dart'; // Add this package
import '../../../../core/errors/failures.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/endpoints.dart';
import '../models/add_apartment_request.dart';
import '../models/add_apartment_response.dart';
import '../models/add_room_request.dart';
import '../models/add_room_response.dart';
import 'add_property_repo.dart';

class AddPropertyRepoImpl extends AddPropertyRepo {
  ApiService apiService;

  AddPropertyRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AddApartmentResponse>> addApartment({
    required AddApartmentRequest request,
  }) async {
    try {
      // We pass the serialized JSON directly to the data body
      final response = await apiService.post(
        Endpoints.addApartment,
        data: request.toJson(),
      );

      return Right(AddApartmentResponse.fromJson(response.data));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }


  @override
  Future<Either<Failure, AddRoomResponse>> addRoom({
    required AddRoomRequest request,
  }) async {
    try {
      final response = await apiService.post(
        Endpoints.addRoom,
        data: request.toJson(),
      );

      return Right(AddRoomResponse.fromJson(response.data));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, UploadImageResponse>> uploadImg({
    required String file,
    required bool isCover,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file,
          contentType: MediaType('image', 'jpeg'), // or 'png'
        ),
      });

      final response = await apiService.post(
        Endpoints.uploadImage,
        queryParameters: {
          'isCover': isCover,
        },
        data: formData,
      );
      return Right(UploadImageResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



}