import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:stay_match/Features/notifications/data/models/delete_notification_response.dart';
import 'package:stay_match/Features/notifications/data/models/get_all_notifications.dart';
import 'package:stay_match/Features/notifications/data/models/get_notifications_by_type.dart';
import 'package:stay_match/Features/notifications/data/models/get_unread_count_resonse.dart';
import 'package:stay_match/Features/notifications/data/models/mark_all_read_response.dart';
import 'package:stay_match/Features/notifications/data/models/read_notification_response.dart';
import 'package:stay_match/core/errors/failures.dart';
import 'package:stay_match/core/networking/api_service.dart';

import '../../../../core/networking/endpoints.dart';
import 'notifications_repo.dart';

class NotificationsRepoImpl extends NotificationsRepo {
  ApiService apiService;

  NotificationsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, GetAllNotifications>> getNotifications() async {
    try {
      var response = await apiService.get(
        Endpoints.getNotifications,
        // data: {},
      );
      return right(GetAllNotifications.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, DeleteNotificationResponse>> deleteNotification({
    required int id,
  })async {
    try {
      var response = await apiService.delete(
        Endpoints.deleteNotification(id),
        // data: {},
      );
      return right(DeleteNotificationResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, GetNotificationsByType>> getNotificationByType({
    required String type,
  }) async {
    try {
      var response = await apiService.post(
        Endpoints.getNotificationsByType,
        queryParameters: {'type':type}
      );
      return right(GetNotificationsByType.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, GetUnreadCountResonse>> getUnreadCount() async {
    try {
      var response = await apiService.get(
        Endpoints.getUnreadNotificationCount,
        // data: {},
      );
      return right(GetUnreadCountResonse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, MarkAllReadResponse>> markAllAsRead() async {
    try {
      var response = await apiService.put(
        Endpoints.markAllNotificationsAsRead,
      );
      return right(MarkAllReadResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ReadNotificationResponse>> readNotificationById({
    required int id,
  }) async {
    try {
      var response = await apiService.put(
        Endpoints.markNotificationAsRead(id),
      );
      return right(ReadNotificationResponse.fromJson(response));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}