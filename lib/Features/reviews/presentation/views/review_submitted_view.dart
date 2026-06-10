import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../widgets/review_submitted_widgets/green_gradient_checkmark.dart';

class ReviewSubmittedView extends StatelessWidget {
  const ReviewSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryScaffBg,
      body: CustomScrollView(
        slivers: [
          // --- Custom App Bar ---
          SliverAppBar(
            backgroundColor: AppColors.containerColor,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            title: Text(
              'Review Submitted',
              style: AppStyles.bold18poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            centerTitle: true,
            pinned: true,
          ),

          // --- Main Content Area (Using Box Adapter instead of Fill Remaining) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32.h),
                  // Success Checkmark Circle
                  const GreenGradientCheckmark(),
                  SizedBox(height: 32.h),

                  // Success Title
                  Text(
                    'Thank you for your\nreview!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorPrimary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Subtitle Description
                  Text(
                    'Your feedback helps improve the Stay Match community and assists other travelers in making better choices. We appreciate you taking the time to share your experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // Primary Button: Return to Home
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: CustomElevatedButton(
                      text: 'Return to Home',
                      onPressed: () {
                        // Handle Home Navigation
                      },
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.textColorWhite,
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      borderRadius: 12,
                      elevation:
                          3, // Directly maps to your custom elevation parameter
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Secondary Button: Explore More
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: CustomElevatedButton(
                      text: 'Explore More',
                      onPressed: () {
                        // Handle Explore More Action
                      },
                      backgroundColor: const Color(0xFFC0E6D4),
                      textColor: AppColors.primary,
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      borderRadius: 12,
                      elevation: 3,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          // recommendation part
          SliverToBoxAdapter(
            child: RPadding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "CURATED JUST FOR YOU",
                    style: AppStyles.bold12manrope.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 2.4.sp,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Recommended",
                        style: AppStyles.bold24plusJakartaSans.copyWith(color: AppColors.textColorPrimary),
                      ),
                      Text("View All",style: AppStyles.bold14manrope.copyWith(color: AppColors.primary),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}