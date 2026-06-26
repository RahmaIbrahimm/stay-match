import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/get_apartment_reviews.dart';
import 'cat_row.dart';
class RatingSummaryCard extends StatelessWidget {
  final Summary summary;

  const RatingSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final cats = [
      Cat('Cleanliness', summary.cleanliness?.toDouble() ?? 0),
      Cat('Accuracy', summary.accuracy?.toDouble() ?? 0),
      Cat('Communication', summary.communication?.toDouble() ?? 0),
      Cat('Location', summary.location?.toDouble() ?? 0),
      Cat('Check-in', summary.checkIn?.toDouble() ?? 0),
      Cat('Value', summary.value?.toDouble() ?? 0),
    ];

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Big score
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: summary.averageRating?.toStringAsFixed(2) ?? '0.00',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.star_rate_rounded,
                    size: 40.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Guest favorite',
            style: AppStyles.semiBold14poppins.copyWith(color: RColors.textPrimary),
          ),
          SizedBox(height: 4.h),
          Text(
            'One of the most loved homes on StayMatch,\naccording to guests',
            textAlign: TextAlign.center,
            style: AppStyles.regular12poppins.copyWith(
              color: RColors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          Divider(color: RColors.divider, thickness: 1),
          SizedBox(height: 12.h),
          ...cats.map((c) => CatRow(label: c.label, value: c.value)),
        ],
      ),
    );
  }
}