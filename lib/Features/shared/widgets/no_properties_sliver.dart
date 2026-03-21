import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
class NoPropertiesSliver extends StatelessWidget {
  const NoPropertiesSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: RPadding(
          padding: EdgeInsets.all(32.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.house_outlined,
                size: 100.sp,
                color: AppColors.primary.withValues(
                  alpha: 0.5,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Apartments Available',
                style: AppStyles.bold28poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'At the Moment',
                style: AppStyles.bold28poppins.copyWith(
                  color: AppColors.textColorSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.r),
                margin: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Please check again later.\nNew apartments are added regularly!',
                  style: AppStyles.regular16poppins.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}