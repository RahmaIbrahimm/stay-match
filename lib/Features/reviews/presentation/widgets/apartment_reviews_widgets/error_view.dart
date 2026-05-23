import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../shared/reviews_helpers.dart';
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 52.r,
              color: AppColors.textColorError,
            ),
            SizedBox(height: 16.h),
            Text(
              'Something went wrong',
              style: AppStyles.bold16poppins.copyWith(color: RColors.textPrimary),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.regular14poppins.copyWith(
                color: RColors.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: RColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              ),
              child: Text(
                'Try Again',
                style: AppStyles.semiBold14poppins.copyWith(color: RColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}