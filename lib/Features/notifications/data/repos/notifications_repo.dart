import 'package:dartz/dartz.dart';
import 'package:stay_match/Features/notifications/data/models/delete_notification_response.dart';
import 'package:stay_match/Features/notifications/data/models/get_all_notifications.dart';
import 'package:stay_match/Features/notifications/data/models/get_notifications_by_type.dart';
import 'package:stay_match/Features/notifications/data/models/get_unread_count_resonse.dart';
import 'package:stay_match/Features/notifications/data/models/mark_all_read_response.dart';
import 'package:stay_match/Features/notifications/data/models/read_notification_response.dart';

import '../../../../core/errors/failures.dart';

abstract class NotificationsRepo {
  Future<Either<Failure,GetAllNotifications>> getNotifications();
  Future<Either<Failure,GetUnreadCountResonse>> getUnreadCount();
  Future<Either<Failure,ReadNotificationResponse>> readNotificationById({required int id});
  Future<Either<Failure,MarkAllReadResponse>> markAllAsRead();
  Future<Either<Failure,GetNotificationsByType>> getNotificationByType({required String type});
  Future<Either<Failure,DeleteNotificationResponse>> deleteNotification({required int id});

}