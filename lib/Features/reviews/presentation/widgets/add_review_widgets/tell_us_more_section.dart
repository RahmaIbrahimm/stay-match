import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class TellUsMoreSection extends StatelessWidget {
  final TextEditingController controller;

  const TellUsMoreSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Tell us more about your experience',
                style: AppStyles.semiBold16poppins.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Icon(
              Icons.info_outline,
              size: 16.r,
              color: AppColors.textColorSecondary,
            ),
          ],
        ),

        SizedBox(height: 12.h),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.stroke),
              ),
              child: TextField(
                controller: controller,
                maxLines: 5,
                maxLength: 500,
                style: AppStyles.regular14poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'What did you love? Was anything missing?',
                  hintStyle: AppStyles.regular14poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.r),
                  counterStyle: AppStyles.regular12poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}