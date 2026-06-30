import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

class HostCard extends StatelessWidget {
  final HostInfo? hostInfo;

  const HostCard({super.key, this.hostInfo});

  @override
  Widget build(BuildContext context) {
    final status = (hostInfo?.status ?? '').toLowerCase();
    final isSuspended = status == 'suspended';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          // Avatar with super-host badge
          Stack(
            children: [
              CircleAvatar(
                radius: 44.r,
                backgroundColor: AppColors.bgGrey,
                backgroundImage:
                    hostInfo?.hostImage != null &&
                        hostInfo!.hostImage!.isNotEmpty
                    ? CachedNetworkImageProvider(hostInfo!.hostImage!)
                    : null,
                child:
                    hostInfo?.hostImage == null || hostInfo!.hostImage!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 44.r,
                        color: AppColors.textColorSecondary,
                      )
                    : null,
              ),
              if (hostInfo?.isSuperHost == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.containerColor,
                        width: 2.r,
                      ),
                    ),
                    child: Icon(
                      Icons.verified,
                      size: 14.r,
                      color: AppColors.textColorWhite,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // Name
          Text(
            hostInfo?.hostName ?? 'Guest',
            style: AppStyles.semiBold18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          SizedBox(height: 8.h),

          // Status badge
          _StatusBadge(status: hostInfo?.status),

          SizedBox(height: 16.h),
          Divider(height: 1, color: AppColors.stroke),
          SizedBox(height: 16.h),

          // Stats row
          Row(
            children: [
              _StatColumn(
                value: hostInfo?.rating != null
                    ? hostInfo!.rating!.toStringAsFixed(1)
                    : '—',
                label: 'RATING',
              ),
              _StatDivider(),
              _StatColumn(
                value: hostInfo?.rentalsCount?.toString() ?? '0',
                label: 'RENTALS',
              ),
              _StatDivider(),
              _StatColumn(
                value: hostInfo?.reviewsCount?.toString() ?? '0',
                label: 'REVIEWS',
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Contact Host button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: CustomElevatedButton(
              text: 'Contact ${hostInfo?.hostName}',
              onPressed: isSuspended
                  ? null
                  : () {
                      if (context.mounted) {
                        context.pushNamed(
                          AppRouting.messagesName,
                          pathParameters: {
                            'otherUserId': hostInfo?.hostId.toString() ?? '',
                          },
                        );
                      }
                    },
              backgroundColor: isSuspended
                  ? AppColors.textColorSecondary
                  : AppColors.primary,
              textColor: AppColors.textColorWhite,
              textStyle: AppStyles.semiBold16poppins,
              borderRadius: 12,
            ),
          ),
        ],
      ),
    );
  }
}
// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String? status;

  const _StatusBadge({this.status});

  @override
  Widget build(BuildContext context) {
    final normalized = (status ?? '').toLowerCase();

    Color bgColor;
    Color textColor;
    IconData? icon;
    String label;

    switch (normalized) {
      case 'verified':
        bgColor = const Color(0xFFE3F6EA);
        textColor = const Color(0xFF1E9E5C);
        icon = Icons.check_circle;
        label = 'Verified';
        break;
      case 'suspended':
        bgColor = const Color(0xFFE0473E);
        textColor = AppColors.textColorWhite;
        icon = null;
        label = 'Suspended';
        break;
      case 'pending':
        bgColor = const Color(0xFFF5B82E);
        textColor = AppColors.textColorWhite;
        icon = null;
        label = 'Pending';
        break;
      default:
        bgColor = AppColors.bgGrey;
        textColor = AppColors.textColorSecondary;
        icon = null;
        label = status ?? 'Unknown';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.r, color: textColor),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: AppStyles.semiBold12poppins.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

// ── Stat column / divider ───────────────────────────────────────────────────────

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppStyles.medium16inter.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: AppStyles.medium12inter.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 32.h, width: 1.w, color: AppColors.stroke);
  }
}