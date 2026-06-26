import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/widgets/custom_elevated_button.dart';

// Assuming CustomElevatedButton is located here
// import 'package:stay_match/core/widgets/custom_elevated_button.dart';

class NoNotificationsBody extends StatelessWidget {
  const NoNotificationsBody({super.key});

  @pragma('vm:entry-point')
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fieldFillColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Central Image Graphic Component
              Image.asset(
                AppImages.noNotificationImg,
                height: 220.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32.h),

              // Primary Main Notification Status Title
              Text(
                'No Notifications Yet',
                textAlign: TextAlign.center,
                style: AppStyles.semiBold24plusJakartaSans.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              SizedBox(height: 16.h),

              // Secondary Description Informative Copy Block
              Text(
                "You're all caught up! When you receive booking updates, messages, reviews, AI recommendations, or important alerts, they'll appear here.",
                textAlign: TextAlign.center,
                style: AppStyles.medium16poppins.copyWith(
                  color: AppColors.textColorSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 32.h),

              // Integrated shared Custom Elevated Action Button Layout
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: CustomElevatedButton(
                  text: 'Back to Home',
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.textColorWhite,
                  textStyle: AppStyles.semiBold16poppins,
                  borderRadius: 12,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 24.h),

              // Brand/App Meta Notification Promise Text Label
              Text(
                'StayMatch will notify you whenever\nsomething important happens.',
                textAlign: TextAlign.center,
                style: AppStyles.medium12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                  height: 1.4,
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),

    );
  }
}