import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/booking/presentation/manager/booking_request_cubit.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/utils/app_keys.dart';
import '../../../data/model/renter_bookings_response.dart';

class RenterBookingRequestCard extends StatelessWidget {
  final RenterBookings? bookings;

  const RenterBookingRequestCard({super.key, required this.bookings});
// todo: add events in all that have booking
  @override
  Widget build(BuildContext context) {

    final statusLower = bookings?.status?.toLowerCase() ?? '';
    var cubit = context.read<BookingRequestCubit>();
    return Container(
      foregroundDecoration: statusLower == 'declined'
          ? BoxDecoration(
        color: Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(24.r),
      )
          : null,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                child: CachedNetworkImage(
                  imageUrl: bookings?.coverImage ?? '',
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildImagePlaceholder(),
                  errorWidget: (context, url, error) => _buildImagePlaceholder(),
                ),
              ),
              Positioned(
                top: 14.h,
                right: 14.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusBgColor(statusLower),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: BoxDecoration(
                          color: _getStatusColor(statusLower),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        bookings?.status ?? 'Pending',
                        style: AppStyles.bold12poppins.copyWith(
                          color: _getStatusColor(statusLower),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookings?.title ?? 'Property Title',
                  style: AppStyles.bold18poppins.copyWith(
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.r,
                      color: const Color(0xFF6B7280),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                       cubit.isFiltered ? bookings?.stringLocation?? '': bookings?.location?.fullAddress ?? '',
                        style: AppStyles.regular12poppins.copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${bookings?.duration?.toInt() ?? 1} ${bookings?.duration?.toInt() == 1 ? 'Month' : 'Months'}',
                        style: AppStyles.medium12poppins.copyWith(
                          color: const Color(0xFF374151),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusLower == 'approved'
                              ? 'MOVE IN DATE'
                              : 'DURATION',
                          style: AppStyles.bold12poppins.copyWith(
                            color: const Color(0xFF9CA3AF),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          statusLower == 'approved'
                              ? _formatCleanDate(bookings?.moveInDate)
                              : '${bookings?.duration?.toInt() ?? 0} Months',
                          style: AppStyles.bold14poppins.copyWith(
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'PRICE',
                          style: AppStyles.bold12poppins.copyWith(
                            color: const Color(0xFF9CA3AF),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        RichText(
                          text: TextSpan(
                            style: AppStyles.bold16poppins.copyWith(
                              color: AppColors.primary,
                            ),
                            children: [
                              TextSpan(
                                text:
                                '${(bookings?.monthlyPrice ?? 0).toStringAsFixed(0)} EGP',
                              ),
                              TextSpan(
                                text: '/month',
                                style: AppStyles.regular12poppins.copyWith(
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildActionButtons(statusLower, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 160.h,
      color: const Color(0xFFE5E7EB),
      child: Icon(Icons.image, size: 40.r, color: const Color(0xFF9CA3AF)),
    );
  }

  Widget _buildActionButtons(String status, BuildContext context) {
    if (status == 'approved') {
      return Row(
        children: [
          Expanded(
            child: _createButton(
              text: 'Chat with host',
              bgColor: AppColors.primary,
              textColor: Colors.white,
              icon: Icons.chat_bubble_outline,
              onPressed: () {
                if (bookings?.host != null) {
                  if (context.mounted) {
                    context.pushNamed(
                      AppRouting.messagesName,
                      pathParameters: {
                        'otherUserId': bookings?.host!.id.toString() ?? '-1',
                      },
                    );
                  } else {
                    AppKeys.rootScaffoldMessengerKey.currentState
                        ?.removeCurrentSnackBar();
                    AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Chat is unavailable for this booking.",
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        margin: EdgeInsets.all(16.w),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _createButton(
              text: 'Add Review',
              bgColor: AppColors.secondary,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      );
    }
    else if (status == 'declined' || status == 'past') {
      return _createButton(
        text: 'Delete',
        bgColor: const Color(0xFFFFF5F5),
        textColor: const Color(0xFFDC2626),
        icon: Icons.delete_outline,
        width: double.infinity,
        onPressed: () {
          if (bookings?.id != null) {
            context.read<BookingRequestCubit>().deletedBookingId =bookings!.id!;
            context.read<BookingRequestCubit>().deleteBooking(bookings!.id!);
          }
        },
      );
    }
    else if(status == 'pending') {
      return Row(
        children: [
          Expanded(
            child: _createButton(
              text: 'Details',
              bgColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _createButton(
              text: 'Cancel',
              bgColor: const Color(0xFFE5E7EB),
              textColor: const Color(0xFF374151),
              onPressed: () {
                if (bookings?.id != null) {
                  context.read<BookingRequestCubit>().canceledBookingId =bookings!.id!;
                  context.read<BookingRequestCubit>().renterCancelBooking(bookings!.id!);
                }
              },
            ),
          ),
        ],
      );
    }
    else {
      return Row(
        children: [
          Expanded(
            child: _createButton(
              text: 'Details',
              bgColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      );
    }
  }

  Widget _createButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    IconData? icon,
    double? width,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: width,
      height: 44.h,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18.r, color: textColor),
              SizedBox(width: 6.w),
            ],
            Text(
              text,
              style: AppStyles.bold14poppins.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF10B981);
      case 'declined':
      case 'past':
        return const Color(0xFFEF4444);
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'cancelled':
        return const Color(0xFF6B7280); // Muted gray for cancelled
      default:
        return const Color(0xFFF59E0B);
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFD1FAE5);
      case 'declined':
      case 'past':
        return const Color(0xFFFEE2E2);
      case 'pending':
        return const Color(0xFFFEF3C7);
      case 'cancelled':
        return const Color(0xFFF3F4F6);
      default:
        return const Color(0xFFFEF3C7);
    }
  }

  String _formatCleanDate(String? isoString) {
    if (isoString == null) return '';
    try {
      final parsed = DateTime.parse(isoString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year}';
    } catch (_) {
      return isoString.split('T').first;
    }
  }
}