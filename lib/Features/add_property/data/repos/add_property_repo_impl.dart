
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // Add this package
import 'package:stay_match/Features/add_property/data/models/update_entire_property_request.dart';
import 'package:stay_match/Features/add_property/data/models/update_entire_property_response.dart';
import 'package:stay_match/Features/add_property/data/models/update_shared_property_request.dart';
import 'package:stay_match/Features/add_property/data/models/update_shared_space_response.dart';
import 'package:stay_match/Features/add_property/data/models/upload_image_response.dart';
import 'package:stay_match/Features/apartments/data/models/property_details_response.dart';

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

      return Right(AddApartmentResponse.fromJson(response));
      // return Right(AddApartmentResponse.fromJson(response.data));
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

      return Right(AddRoomResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, UploadImageResponse>> uploadPropertyImg({
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

  @override
  Future<Either<Failure, UpdateEntirePropertyResponse>> updateApartment(
      {required UpdateEntirePropertyRequest request, required int id}) async {
    try {
      final response = await apiService.post(
        Endpoints.updateEntireProperty(id),
        data: request.toJson(),
      );

      return Right(UpdateEntirePropertyResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, UpdateSharedSpaceResponse>> updateRoom(
      {required UpdateSharedPropertyRequest request, required int id}) async {
    try {
      final response = await apiService.put(
        Endpoints.updateSharedProperty(id),
        data: request.toJson(),
      );

      return Right(UpdateSharedSpaceResponse.fromJson(response));
    } on DioException catch (e) {
      // Handle specific Dio/Server errors here
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, PropertyDetailsResponse>> getPropertyDetails({required int id}) async {
    try {
      final response = await apiService.get(
        '${Endpoints.getPropertyDetails}$id',
      );
      return Right(PropertyDetailsResponse.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}