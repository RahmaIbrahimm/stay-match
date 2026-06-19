import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart'; // 📌 Define your new landing image string here
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/widgets/custom_elevated_button.dart';
import '../routing/app_routing.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7FAFF), // Light soft blue-white backdrop tint
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),

                // 📝 1. Top Section App Brand Header
                Text(
                  "StayMatch",
                  style: AppStyles.bold18poppins.copyWith(
                    color: const Color(0xFF002270), // Deep brand navy
                    fontSize: 20.sp,
                  ),
                ),

                SizedBox(height: 32.h),

                // 🖼️ 2. Central App Main Logo & Vector Illustration Graphic Asset
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: SizedBox(
                    height: 240.h,
                    width: double.infinity,
                    child: Image.asset(
                      AppImages.mainLogo, // 📌 TODO: Add your welcome graphic asset string to your constants
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // 📝 3. Welcome Texts Information Block
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      Text(
                        "Welcome to\nStayMatch",
                        textAlign: TextAlign.center,
                        style: AppStyles.bold24poppins.copyWith(
                          color: const Color(0xFF002270),
                          fontSize: 28.sp,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Find apartments, rooms, and compatible roommates with the help of AI. Our smart matching system helps you discover the perfect place to live based on your lifestyle, preferences, and personality.",
                        textAlign: TextAlign.center,
                        style: AppStyles.medium14poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 48.h),

                // 🔘 4. Double Action Authentication Buttons Track
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Sign Up Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: CustomElevatedButton(
                          text: AppStrings.signUp,
                          borderRadius: 14,
                          textStyle: AppStyles.semiBold16manrope,
                          backgroundColor: AppColors.primary, // Deep navy primary shade
                          textColor: Colors.white,
                          onPressed: () {
                            context.goNamed(AppRouting.signupViewName);
                          },
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // Login Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: CustomElevatedButton(
                          text: AppStrings.login,
                          borderRadius: 14,
                          textStyle: AppStyles.semiBold16manrope,
                          backgroundColor: AppColors.secondary,
                          textColor: AppColors.textColorPrimary,
                          onPressed: () {
                            // TODO: Add navigation routing sequence to target login interface screen
                            context.goNamed(AppRouting.loginViewName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h), // Safe structural margin padding clearance bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}