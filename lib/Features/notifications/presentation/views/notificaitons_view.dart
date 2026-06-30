import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/notifications/data/models/get_all_notifications.dart';
import 'package:stay_match/Features/notifications/presentation/widgets/no_notifications_body.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/utils/app_keys.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../core/routing/app_routing.dart';
import '../manager/notifications_cubit.dart';

// ─── Notification type helpers ───────────────────────────────────────────────

Color borderColor(String? type) {
  switch (type) {
    case 'booking_request':
      return AppColors.primary;
    case 'booking_confirmed':
    case 'property_approved':
      return const Color(0xFF43A047);
    case 'booking_declined':
      return const Color(0xFFE53935);
    case 'message':
      return AppColors.primary;
    case 'profile':
      return const Color(0xFFFF9800);
    case 'review':
      return const Color(0xFF9C27B0);
    case 'system':
    default:
      return AppColors.grey;
  }
}

Color iconBgColor(String? type) {
  switch (type) {
    case 'booking_request':
      return AppColors.primary.withValues(alpha: 0.12);
    case 'booking_confirmed':
    case 'property_approved':
      return const Color(0xFFE8F5E9);
    case 'booking_declined':
      return const Color(0xFFFFEBEE);
    case 'message':
      return AppColors.primary.withValues(alpha: 0.12);
    case 'profile':
      return const Color(0xFFFFF3E0);
    case 'review':
      return const Color(0xFFF3E5F5);
    case 'system':
    default:
      return AppColors.bgGrey;
  }
}

IconData iconData(String? type) {
  switch (type) {
    case 'booking_request':
      return Icons.calendar_today_outlined;
    case 'booking_confirmed':
      return Icons.check_circle_outline;
    case 'booking_declined':
      return Icons.cancel_outlined;
    case 'message':
      return Icons.chat_bubble_outline;
    case 'profile':
      return Icons.error_outline;
    case 'property_approved':
      return Icons.verified_outlined;
    case 'review':
      return Icons.star_outline;
    case 'system':
    default:
      return Icons.info_outline;
  }
}

Color iconColor(String? type) => borderColor(type);

// ─── View ─────────────────────────────────────────────────────────────────────

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();
    cubit.fetchNotifications();
    cubit.connectHub();
    return NotificationsScaffold();
  }
}

class NotificationsScaffold extends StatelessWidget {
  const NotificationsScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainAppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: Text(
          'Notifications',
          style: AppStyles.bold24poppins.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is MarkAllReadFailure ||
              state is DeleteNotificationFailure) {
            final msg = state is MarkAllReadFailure
                ? state.errMessage
                : (state as DeleteNotificationFailure).errMessage;
            AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: AppColors.primary,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16.r),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is NotificationsFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errMessage,
                    textAlign: TextAlign.center,
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () =>
                        context.read<NotificationsCubit>().fetchNotifications(),
                    child: Text(
                      'Try again',
                      style: AppStyles.semiBold14poppins.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is NotificationsSuccess) {
            var notifications = state.response.data?.allNotifications ?? [];
            return notifications.isNotEmpty
                ? NotificationsBody(data: state.response.data!)
                : NoNotificationsBody();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────────

class NotificationsBody extends StatelessWidget {
  final Data data;

  const NotificationsBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final today = data.today ?? [];
    final yesterday = data.yesterday ?? [];
    final last7 = data.last7Days ?? [];
    final older = data.older ?? [];

    return RefreshIndicator(
      onRefresh: ()async{
        context.read<NotificationsCubit>().fetchNotifications();
      },
      child: CustomScrollView(
        slivers: [
          // ── Header: title + mark all as read ──────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: AppStyles.bold24poppins.copyWith(
                            color: AppColors.textColorPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Stay updated with your latest activities.',
                          style: AppStyles.regular12poppins.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  MarkAllReadButton(),
                ],
              ),
            ),
          ),

          // ── Today ─────────────────────────────────────────────────────
          if (today.isNotEmpty) ...[
            SectionHeader(label: 'TODAY'),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => NotificationCard(
                  n: _toGeneric(today[i], senderId: data.today?[i].senderId),
                ),
                childCount: today.length,
              ),
            ),
          ],

          // ── Yesterday ─────────────────────────────────────────────────
          if (yesterday.isNotEmpty) ...[
            SectionHeader(label: 'YESTERDAY'),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => NotificationCard(
                  n: _toGeneric(
                    yesterday[i],
                    senderId: data.yesterday?[i].senderId,
                  ),
                ),
                childCount: yesterday.length,
              ),
            ),
          ],

          // ── Last 7 days ───────────────────────────────────────────────
          if (last7.isNotEmpty) ...[
            SectionHeader(label: 'LAST 7 DAYS'),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => NotificationCard(
                  n: _toGeneric(last7[i], senderId: data.last7Days?[i].senderId),
                ),
                childCount: last7.length,
              ),
            ),
          ],

          // ── Older ─────────────────────────────────────────────────────
          if (older.isNotEmpty) ...[
            SectionHeader(label: 'OLDER'),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => NotificationCard(n: _toGeneric(older[i])),
                childCount: older.length,
              ),
            ),
          ],

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
        ],
      ),
    );
  }

  NotifData _toGeneric(dynamic n, {String? senderId}) => NotifData(
    id: n.id?.toInt() ?? 0,
    type: n.type,
    title: n.title,
    message: n.message,
    time: n.time,
    senderName: n.senderName?.toString(),
    senderImage: n.senderImage?.toString(),
    senderId: senderId?.toString(),
    isRead: n.isRead ?? false,
    propertyId: n.propertyId?.toInt(),
    roomId: n.roomId?.toInt(),
  );
}

// ─── Generic notification data wrapper ───────────────────────────────────────

class NotifData {
  final int id;
  final int? propertyId;
  final int? roomId;
  final String? type;
  final String? title;
  final String? message;
  final String? time;
  final String? senderName;
  final String? senderImage;
  final String? senderId;
  final bool isRead;

  const NotifData({
    required this.id,
    this.type,
    this.title,
    this.message,
    this.time,
    this.senderName,
    this.senderImage,
    required this.isRead,
    this.senderId,
    this.propertyId,
    this.roomId,
  });
}

// ─── Section header ───────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String label;

  const SectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 6.h),
        child: Text(
          label,
          style: AppStyles.bold12poppins.copyWith(
            color: AppColors.textColorSecondary,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

// ─── Mark all as read button ──────────────────────────────────────────────────

class MarkAllReadButton extends StatelessWidget {
  const MarkAllReadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final isLoading = state is MarkAllReadLoading;
        return GestureDetector(
          onTap: isLoading
              ? null
              : () => context.read<NotificationsCubit>().markAllAsRead(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.stroke),
              boxShadow: AppColors.elevationShadow,
            ),
            child: isLoading
                ? SizedBox(
                    width: 16.r,
                    height: 16.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.done_all,
                        size: 14.r,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Mark all as read',
                        style: AppStyles.semiBold12poppins.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

// ─── Notification card ────────────────────────────────────────────────────────
class NotificationCard extends StatefulWidget {
  final NotifData n;

  const NotificationCard({super.key, required this.n});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late bool _isRead; // ← local mutable copy
  @override
  void initState() {
    super.initState();
    _isRead = widget.n.isRead; // ← initialize from widget
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.n.id),
      direction: widget.n.isRead
          ? DismissDirection.endToStart
          : DismissDirection.horizontal,

      // Left-to-right → mark as read (green)
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(Icons.done_all, color: const Color(0xFF43A047), size: 24.r),
      ),

      // Right-to-left → delete (red)
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(
          Icons.delete_outline,
          color: const Color(0xFFE53935),
          size: 24.r,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          context.read<NotificationsCubit>().deleteNotification(
              id: widget.n.id);
        } else
        if (direction == DismissDirection.startToEnd && !widget.n.isRead) {
          context.read<NotificationsCubit>().markAsRead(id: widget.n.id);
          setState(() {
            _isRead = true;
          });
        }
        return false; // cubit handles list update
      },

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: !_isRead ? Colors.white : AppColors.grey,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.stroke),
          boxShadow: AppColors.elevationShadow,
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left accent border
              Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: borderColor(widget.n.type),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Avatar(n: widget.n),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.n.title ?? '',
                                        style: AppStyles.semiBold14poppins
                                            .copyWith(
                                              color: AppColors.textColorPrimary,
                                            ),
                                      ),
                                    ),
                                    if (!_isRead)
                                      Container(
                                        width: 9.r,
                                        height: 9.r,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  widget.n.time ?? '',
                                  style: AppStyles.regular10poppins.copyWith(
                                    color: AppColors.textColorSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.n.message ?? '',
                        style: AppStyles.regular14poppins.copyWith(
                          color: AppColors.textColorSecondary,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ActionButtons(n: widget.n, onRead: () {
                        if (!_isRead) {
                          context.read<NotificationsCubit>().markAsRead(
                              id: widget.n.id);
                          setState(() => _isRead = true);
                        }
                      },),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ─── Avatar (sender image or type icon) ──────────────────────────────────────

class Avatar extends StatelessWidget {
  final NotifData n;

  const Avatar({super.key, required this.n});

  @override
  Widget build(BuildContext context) {
    final hasSenderImage = n.senderImage != null && n.senderImage!.isNotEmpty;
    if (hasSenderImage) {
      return CircleAvatar(
        radius: 22.r,
        backgroundColor: AppColors.bgGrey,
        backgroundImage: CachedNetworkImageProvider(n.senderImage!),
      );
    }
    return Container(
      width: 44.r,
      height: 44.r,
      decoration: BoxDecoration(
        color: iconBgColor(n.type),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData(n.type), size: 20.r, color: iconColor(n.type)),
    );
  }
}

// ─── Action buttons by type ───────────────────────────────────────────────────

class ActionButtons extends StatelessWidget {
  final NotifData n;
  final VoidCallback onRead; // ← add this

  const ActionButtons({super.key, required this.n, required this.onRead});

  @override
  Widget build(BuildContext context) {
    switch (n.type) {
      case 'booking_request':
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CardBtn(
            label: 'Review',
            filled: true,
            onTap: () {
              onRead(); // ← add to every case
              if (context.mounted) {
                context.pushNamed(AppRouting.hostBookingsName);
              }
            },
          ),
        );

      case 'message':
        return Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: CardBtn(
            label: 'Reply',
            filled: false,
            onTap: () {
              if (context.mounted) {
                context.pushNamed(
                  AppRouting.messagesName,
                  pathParameters: {'otherUserId': n.senderId ?? '-1'},
                );
              }
            },
          ),
        );

      case 'profile':
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: GestureDetector(
            onTap: () {
              context.goNamed(AppRouting.profileName);
            },
            child: Text(
              'UPDATE PROFILE',
              style: AppStyles.bold12poppins.copyWith(
                color: AppColors.primary,
                letterSpacing: 0.3,
              ),
            ),
          ),
        );

      case 'property_approved':
      case 'system':
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CardBtn(
            label: 'View Property',
            filled: false,
            onTap: () {
              context.goNamed(AppRouting.myPropertiesName);
            },
          ),
        );

      case 'booking_confirmed':
      case 'booking_declined':
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CardBtn(
            label: 'View Booking',
            filled: false,
            onTap: () {
              context.goNamed(AppRouting.renterBookingsName);
            },
          ),
        );

      case 'review':
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CardBtn(
            label: 'Reply to review',
            filled: true,
            onTap: () {
              if (context.mounted) {
                context.pushNamed(
                  AppRouting.showReviewsName,
                  queryParameters: {'isRoom': (n.roomId != null).toString()},
                  pathParameters: n.roomId != null
                      ? {'propertyId': n.roomId.toString()}
                      : {'propertyId': n.propertyId.toString()},
                );
              }
            },
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

class CardBtn extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const CardBtn({
    super.key,
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: filled ? AppColors.primary : AppColors.stroke,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppStyles.semiBold12poppins.copyWith(
            color: filled ? Colors.white : AppColors.textColorPrimary,
          ),
        ),
      ),
    );
  }
}