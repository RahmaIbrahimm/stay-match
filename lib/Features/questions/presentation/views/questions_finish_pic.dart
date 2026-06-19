import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart'; // Make sure to add the new image key here!
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/widgets/custom_elevated_button.dart';

class QuestionsFinishView extends StatelessWidget {
  const QuestionsFinishView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Pure white background canvas

      // 📑 1. Styled AppBar Matching the Finish Design Mockup
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "StayMatch", // 🌟 Title changes to StayMatch here
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 26.h),

            // 🖼️ 2. Centered Pre-rendered Success Checkmark Graphics Asset
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Center(
                child: SizedBox(
                  height: 280.h,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.finishQuestionsPic, // 🌟 Pre-rendered image containing the check circles asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // 📝 3. Core Success Screen Text Layout Copy
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Text(
                    "You're All Set!", // 🌟 Match text exactly
                    textAlign: TextAlign.center,
                    style: AppStyles.bold20poppins.copyWith(
                      color: AppColors.textColorPrimary,
                      fontSize: 28.sp,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Your roommate profile has been successfully completed. Our AI is now analyzing your preferences to recommend the most compatible apartments, rooms, and roommates for you.",
                    textAlign: TextAlign.center,
                    style: AppStyles.medium14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 56.h),

            // 🔘 4. Single Global Home Navigation Action Button Track
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SizedBox(
                width: double.infinity,
                height: 52.h, // Retains identical uniform hit bounds matching the start screen
                child: CustomElevatedButton(
                  text: "Back to Home", // 🌟 Simple center alignment text text layout
                  borderRadius: 14,
                  textStyle: AppStyles.semiBold16manrope.copyWith(fontSize: 15.sp),
                  backgroundColor: const Color(0xFF002270), // Matches deep dark brand navy blue from layout image
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: Execute popping the entire question wizard stack or push Replacement straight to Home layout view segment
                  },
                ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}