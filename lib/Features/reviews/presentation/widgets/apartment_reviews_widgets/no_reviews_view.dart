import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_styles.dart';
import '../shared/reviews_helpers.dart';
class NoReviewsView extends StatelessWidget {
  const NoReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.rate_review_outlined, size: 52.r, color: RColors.divider),
        SizedBox(height: 12.h),
        Text(
          'No reviews yet',
          style: AppStyles.semiBold16poppins.copyWith(color: RColors.textPrimary),
        ),
        SizedBox(height: 6.h),
        Text(
          'Be the first to leave a review',
          style: AppStyles.regular14poppins.copyWith(color: RColors.textSecondary),
        ),
      ],
    );
  }
}