import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');

      case DioExceptionType.unknown:
        if (dioError.error?.toString().contains('SocketException') ?? false) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again.');
      default:
        return ServerFailure('Oops There was an Error, Please try again.');
    }
  }
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      // 1. Check if the response is actually a Map
      if (response is Map<String, dynamic>) {
        // 2. Check if 'message' or 'error' keys exist, otherwise provide a fallback
        return ServerFailure(
          response['message']?.toString() ??
              response['error']?.toString() ??
              'Authentication failed',
        );
      } else if (response is String) {
        // 3. If the server sent a plain string
        return ServerFailure(response);
      } else {
        // 4. Default fallback for unknown formats
        return ServerFailure('An unexpected authentication error occurred');
      }
    } else if (statusCode == 404) {
      return ServerFailure('Your request was not found, Please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try again later');
    } else {
      return ServerFailure('Oops There was an Error, Please try again');
    }
  }}