import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key, required this.stepNumber,
  });

  final int stepNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $stepNumber OF 4',
              style: AppStyles.medium12poppins.copyWith(
                  color: AppColors.primary),

            ),
            Text(
              "${(stepNumber/4 * 100).toInt()}% ${AppStrings.complete}",
              style: AppStyles.medium12poppins.copyWith(
                  color: AppColors.textColorSecondary),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: stepNumber / 4,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          borderRadius: BorderRadius.circular(10),
          minHeight: 8.h,
        ),
      ],
    );
  }
}