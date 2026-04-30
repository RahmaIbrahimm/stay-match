import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class GlobalErrorWidget extends StatelessWidget {
  final VoidCallback onTryAgain;
  final VoidCallback? onReturnHome; // Optional

  const GlobalErrorWidget({
    super.key,
    required this.onTryAgain,
    this.onReturnHome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. The Illustration
          // Note: Add this image to your assets and update the path
          Image.asset(AppImages.errorImg, width: 250.r, height: 250.r),
          SizedBox(height: 32.h),

          // 2. Bold Heading
          Text(
            'Oops! Something went wrong.',
            textAlign: TextAlign.center,
            style: AppStyles.bold24poppins.copyWith(
              color: AppColors.textColorPrimary, // Specific dark color from image
            ),
          ),
          SizedBox(height: 16.h),

          // 3. Descriptive Subtitle
          Text(
            "We couldn't load the page you're looking for. Please check your internet connection or try again later.",
            textAlign: TextAlign.center,
            style: AppStyles.regular16poppins.copyWith(
              color: const Color(0xFF757575), // Gray color from image
              height: 1.5, // To match the line-height in the design
            ),
          ),
          SizedBox(height: 48.h),

          // 4. Try Again Button
          SizedBox(
            width: double.infinity,
            height: 55.h,
            child: ElevatedButton(
              onPressed: onTryAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D2F6F),
                // Deep Blue from image
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // 5. Return to Home Button (Light style)
          if (onReturnHome != null)
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: OutlinedButton(
                onPressed: onReturnHome,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8EDF4),
                  // Light blue-gray background
                  side: BorderSide.none,
                  // Remove the border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Return to Home',
                  style: TextStyle(
                    color: const Color(0xFF1D2F6F),
                    // Use the dark blue for text
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}