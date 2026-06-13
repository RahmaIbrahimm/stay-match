import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class FeedbackPortalHeader extends StatelessWidget {
  final String propertyName;
  final String stayDates;

  const FeedbackPortalHeader({
    required this.propertyName,
    required this.stayDates,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColors.blueGrey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'FEEDBACK PORTAL',
            style: AppStyles.semiBold10poppins.copyWith(
              color: AppColors.primary,
              letterSpacing: 0.8,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'How was your stay at $propertyName?',
          style: AppStyles.bold24poppins.copyWith(
            color: AppColors.primary,
            height: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 14.r,
              color: AppColors.textColorSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              stayDates,
              style: AppStyles.regular12poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}