import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/notifications/data/models/get_all_notifications.dart';
import 'package:stay_match/Features/notifications/data/repos/notifications_repo_impl.dart';

import '../../../../core/networking/notifications_service.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepoImpl repo;
  final NotificationService _notificationService = NotificationService();

  GetAllNotifications? _cached;
  bool _hubStarted = false;
  bool hasUnread = false;
  GetAllNotifications get cached => _cached ?? GetAllNotifications();
  NotificationsCubit({required this.repo}) : super(NotificationsInitial());

  Future<void> connectHub() async {
    if (_hubStarted) return;
    _hubStarted = true;
    await _notificationService.initHub(onRefresh: fetchNotifications);
    await fetchNotifications(); // ✅ CHANGE 1: fetch on startup for initial icon state
  }

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    final result = await repo.getNotifications();
    result.fold(
          (f) => emit(NotificationsFailure(errMessage: f.errMessage)),
          (r) {
        if (r.isSuccess == true) {
          _cached = r;
          // ✅ CHANGE 2: set hasUnread BEFORE emitting so BlocBuilder reads correct value
          hasUnread = r.data?.allNotifications?.any((n) => n.isRead == false) ?? false;
          emit(NotificationsSuccess(response: r));
        } else {
          emit(NotificationsFailure(errMessage: r.message ?? 'Failed'));
        }
      },
    );
  }

  Future<void> markAllAsRead() async {
    emit(MarkAllReadLoading());
    final result = await repo.markAllAsRead();
    result.fold(
          (f) => emit(MarkAllReadFailure(errMessage: f.errMessage)),
          (r) {
        if (r.isSuccess == true) {
          _markAllReadLocally();
          emit(MarkAllReadSuccess());
          if (_cached != null) {
            Future.delayed(Duration.zero, () {
              if (!isClosed) emit(NotificationsSuccess(response: _cached!));
            });
          }
        } else {
          emit(MarkAllReadFailure(errMessage: r.message ?? 'Failed'));
        }
      },
    );
  }

  Future<void> markAsRead({required int id}) async {
    if (_isAlreadyRead(id)) return;
    _setReadById(id, value: true);
    if (_cached != null) emit(NotificationsSuccess(response: _cached!));

    final result = await repo.readNotificationById(id: id);
    result.fold(
          (f) {
        _setReadById(id, value: false);
        if (_cached != null) emit(NotificationsSuccess(response: _cached!));
      },
          (r) {
        if (r.isSuccess != true) {
          _setReadById(id, value: false);
          if (_cached != null) emit(NotificationsSuccess(response: _cached!));
        }
      },
    );
  }

  bool _isAlreadyRead(int id) {
    final all = _cached?.data?.allNotifications;
    if (all == null) return false;
    try {
      return all.firstWhere((n) => n.id?.toInt() == id).isRead == true;
    } catch (_) {
      return false;
    }
  }

  void _setReadById(int id, {required bool value}) {
    if (_cached?.data == null) return;
    final d = _cached!.data!;

    for (final n in d.allNotifications ?? []) {
      if (n.id?.toInt() == id) n.isRead = value;
    }
    for (final n in d.today ?? []) {
      if (n.id?.toInt() == id) n.isRead = value;
    }
    for (final n in d.yesterday ?? []) {
      if (n.id?.toInt() == id) n.isRead = value;
    }
    for (final n in d.last7Days ?? []) {
      if (n.id?.toInt() == id) n.isRead = value;
    }
    for (final n in d.older ?? []) {
      if (n.id?.toInt() == id) n.isRead = value;
    }

    hasUnread =
        _cached!.data!.allNotifications?.any((n) => n.isRead == false) ?? false;
  }

  Future<void> deleteNotification({required int id}) async {
    final result = await repo.deleteNotification(id: id);
    result.fold(
          (f) => emit(DeleteNotificationFailure(errMessage: f.errMessage)),
          (r) {
        if (r.isSuccess == true) {
          _removeLocallyById(id);
          emit(DeleteNotificationSuccess(deletedId: id));
          if (_cached != null) emit(NotificationsSuccess(response: _cached!));
        } else {
          emit(DeleteNotificationFailure(errMessage: r.message ?? 'Failed'));
        }
      },
    );
  }

  Future<void> getUnreadCount() async {
    final result = await repo.getUnreadCount();
    result.fold(
          (f) => emit(GetUnreadCountFailure(errMessage: f.errMessage)),
          (r) {
        if (r.isSuccess == true) {
          emit(GetUnreadCountSuccess());
          _markAllReadLocally();
        } else {
          emit(GetUnreadCountFailure(errMessage: r.message ?? 'Failed'));
        }
      },
    );
  }

  void _markAllReadLocally() {
    if (_cached?.data == null) return;
    final d = _cached!.data!;
    d.today?.forEach((n) => n.isRead = true);
    d.yesterday?.forEach((n) => n.isRead = true);
    d.last7Days?.forEach((n) => n.isRead = true);
    d.older?.forEach((n) => n.isRead = true);
    d.allNotifications?.forEach((n) => n.isRead = true);
    hasUnread = false;
  }

  void _removeLocallyById(int id) {
    if (_cached?.data == null) return;
    final d = _cached!.data!;
    d.today?.removeWhere((n) => n.id == id);
    d.yesterday?.removeWhere((n) => n.id == id);
    d.last7Days?.removeWhere((n) => n.id == id);
    d.older?.removeWhere((n) => n.id == id);
    d.allNotifications?.removeWhere((n) => n.id == id);
  }

  @override
  Future<void> close() {
    _notificationService.stopHub();
    return super.close();
  }
}