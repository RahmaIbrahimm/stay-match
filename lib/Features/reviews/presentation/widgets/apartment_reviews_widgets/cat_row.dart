import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class CatRow extends StatelessWidget {
  final String label;
  final double value;

  const CatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppStyles.regular14poppins.copyWith(
                color: RColors.textPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 130.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: value / 5.0,
                minHeight: 4.h,
                backgroundColor: AppColors.primary,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 28.w,
            child: Text(
              value.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: AppStyles.regular14poppins.copyWith(
                color: RColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}