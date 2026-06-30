import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/Features/other_user_profile/presentation/widgets/star_rating.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class UserReviewCard extends StatelessWidget {
  final RecentReviews review;

  const UserReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.bgGrey,
                backgroundImage:
                    review.reviewerImage != null &&
                        review.reviewerImage!.isNotEmpty
                    ? CachedNetworkImageProvider(review.reviewerImage!)
                    : null,
                child:
                    review.reviewerImage == null ||
                        review.reviewerImage!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 20.r,
                        color: AppColors.textColorSecondary,
                      )
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName?.trim() ?? 'Anonymous',
                      style: AppStyles.regular16inter.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                    Text(
                      _formatDate(review.createdAt),
                      style: AppStyles.medium12inter.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StarRating(rating: review.rating?.toDouble() ?? 0),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            '"${review.comment ?? ''}"',
            style: AppStyles.regular14inter.copyWith(
              color: AppColors.textColorSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      const months = [
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
      return '${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return '';
    }
  }
}