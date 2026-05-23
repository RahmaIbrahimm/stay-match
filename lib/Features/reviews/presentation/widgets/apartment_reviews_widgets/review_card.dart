import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/get_apartment_reviews.dart';
import '../shared/reviews_helpers.dart';
class ReviewCard extends StatelessWidget {
  final Reviews review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final hasResponse =
        review.hostResponse != null &&
            review.hostResponse.toString().trim().isNotEmpty;

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Reviewer row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundImage: review.reviewerImage != null
                    ? NetworkImage(review.reviewerImage!)
                    : null,
                backgroundColor: RColors.divider,
                child: review.reviewerImage == null
                    ? Icon(Icons.person, size: 20.r, color: RColors.textSecondary)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName ?? 'Guest',
                      style: AppStyles.bold14poppins.copyWith(
                        color: RColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _formatDate(review.createdAt),
                      style: AppStyles.regular12poppins.copyWith(
                        color: RColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // ── Star ★ N.N  right-aligned, dark text ──
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, size: 16.r, color: RColors.textPrimary),
                  SizedBox(width: 3.w),
                  Text(
                    review.rating?.toStringAsFixed(1) ?? '0.0',
                    style: AppStyles.bold14poppins.copyWith(
                      color: RColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // ── Comment ──
          Text(
            review.comment ?? '',
            style: AppStyles.regular14poppins.copyWith(
              color: RColors.textPrimary,
              height: 1.55,
            ),
          ),
          SizedBox(height: 12.h),

          // ── VERIFIED STAY — blue checkmark + blue text ──
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 14.r, color: AppColors.primary),
                SizedBox(width: 5.w),
                Text(
                  'VERIFIED STAY',
                  style: AppStyles.bold10poppins.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),

          // ── Helpful / Comment ──
          Row(
            children: [
              Icon(
                Icons.thumb_up_alt_outlined,
                size: 16.r,
                color: RColors.textSecondary,
              ),
              SizedBox(width: 5.w),
              Text(
                'Helpful',
                style: AppStyles.regular12poppins.copyWith(
                  color: RColors.textSecondary,
                ),
              ),
              SizedBox(width: 20.w),
              Icon(
                Icons.chat_bubble_outline,
                size: 16.r,
                color: RColors.textSecondary,
              ),
              SizedBox(width: 5.w),
              Text(
                'Comment',
                style: AppStyles.regular12poppins.copyWith(
                  color: RColors.textSecondary,
                ),
              ),
            ],
          ),

          // ── HOST RESPONSE — light blue bg, left indigo border, amber label ──
          if (hasResponse) ...[
            SizedBox(height: 14.h),
            Container(
              decoration: BoxDecoration(
                color: RColors.hostRespBg,
                borderRadius: BorderRadius.circular(10.r),
                border: Border(
                  left: BorderSide(color: RColors.hostRespBorder, width: 3.w),
                ),
              ),
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.reply_rounded,
                        size: 14.r,
                        color: RColors.hostRespLabel,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'HOST RESPONSE',
                        style: AppStyles.bold10poppins.copyWith(
                          color: RColors.hostRespLabel,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '"${review.hostResponse}"',
                    style: AppStyles.regular14poppins.copyWith(
                      color: RColors.textPrimary,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  if (review.responseCreatedAt != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      _formatDate(review.responseCreatedAt?.toString()),
                      style: AppStyles.regular10poppins.copyWith(
                        color: RColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null) return '';
    try {
      final dt = DateTime.parse(iso);
      const m = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${m[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return '';
    }
  }
}