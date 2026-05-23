import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';

import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/get_apartment_reviews.dart';
class DistributionSection extends StatelessWidget {
  final Summary summary;

  const DistributionSection({required this.summary});

  @override
  Widget build(BuildContext context) {
    final dist = summary.distribution;
    final total = (summary.totalReviews ?? 1).clamp(1, 999999);
    final rows = [
      Dist(5, dist?.five ?? 0),
      Dist(4, dist?.four ?? 0),
      Dist(3, dist?.three ?? 0),
      Dist(2, dist?.two ?? 0),
      Dist(1, dist?.one ?? 0),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review distribution',
            style: AppStyles.bold16poppins.copyWith(color: RColors.textPrimary),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
              children: rows.map((r) {
                final frac = r.count / total;
                return Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                        child: Text(
                          '${r.star}',
                          style: AppStyles.regular12poppins.copyWith(
                            color: RColors.textSecondary,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: frac.toDouble(),
                            minHeight: 6.h,
                            backgroundColor: RColors.barBg,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              RColors.barFill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}