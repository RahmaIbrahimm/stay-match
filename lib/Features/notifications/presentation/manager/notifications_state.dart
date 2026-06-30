part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsSuccess extends NotificationsState {
  final GetAllNotifications response;

  const NotificationsSuccess({required this.response});
  @override
  List<Object?> get props => [];
}
class NotificationsFailure extends NotificationsState {
  final String errMessage;
  const NotificationsFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}

class MarkAllReadLoading extends NotificationsState {}
class MarkAllReadSuccess extends NotificationsState {}
class MarkAllReadFailure extends NotificationsState {
  final String errMessage;
  const MarkAllReadFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}

class GetUnreadCountLoading extends NotificationsState {}
class GetUnreadCountSuccess extends NotificationsState {}
class GetUnreadCountFailure extends NotificationsState {
  final String errMessage;
  const GetUnreadCountFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}

class DeleteNotificationSuccess extends NotificationsState {
  final int deletedId;
  const DeleteNotificationSuccess({required this.deletedId});
  @override
  List<Object?> get props => [deletedId];
}
class DeleteNotificationFailure extends NotificationsState {
  final String errMessage;
  const DeleteNotificationFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}