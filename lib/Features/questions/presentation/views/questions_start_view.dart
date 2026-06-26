import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../../../../core/widgets/custom_elevated_button.dart';

class QuestionsStartView extends StatelessWidget {
  const QuestionsStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🌟 UI shows a clean, crisp pure white background canvas

      // 📑 1. Premium Styled AppBar matching design exactly
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Start Matching", // 🌟 Match design file title exactly
          style: AppStyles.bold18poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(
            color: Colors.grey.withOpacity(0.1),
            thickness: 1.h,
            height: 1.h,
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center align elements matching design mockup layout
          children: [

            // 🖼️ 2. Pre-rendered Centered Graphics Asset Container Frame
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Center(
                child: SizedBox(
                  height: 280.h,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.startMatchingPic, // Entire image frame with embedded asset shadow
                    fit: BoxFit.cover,
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // 📝 3. Correct Core Onboarding Layout Copy
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Text(
                    "Find Your Perfect\nRoommate", // 🌟 Match text exactly with vertical block break style
                    textAlign: TextAlign.center,
                    style: AppStyles.bold24poppins.copyWith(
                      color: AppColors.textColorPrimary,
                      fontSize: 26.sp,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Answer a few quick questions and let us match you with the most compatible apartments, rooms, and roommates based on your lifestyle and preferences.",
                    textAlign: TextAlign.center,
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // 🔘 4. Double Premium Actions Track
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  // Primary Blue Action Button: Start Matching
                  SizedBox(
                    width: double.infinity,
                    height: 52.h, // Fixed uniform design touch height parameters
                    child: CustomElevatedButton(
                      text: "Start Matching",
                      borderRadius: 14,
                      textStyle: AppStyles.semiBold16manrope.copyWith(fontSize: 15.sp),
                      backgroundColor: const Color(0xFF002270), // 🌟 Primary deep dark blue from your mockup layout image
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18.r,
                      ),
                      onPressed: () {
                        context.goNamed(AppRouting.questionsName);
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}