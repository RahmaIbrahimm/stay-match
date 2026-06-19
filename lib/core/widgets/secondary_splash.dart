import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart'; // Make sure to add this image key here
import 'package:stay_match/core/constants/app_styles.dart';

class SecondarySplashView extends StatefulWidget {
  const SecondarySplashView({super.key});

  @override
  State<SecondarySplashView> createState() => _SecondarySplashViewState();
}

class _SecondarySplashViewState extends State<SecondarySplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // 🔁 Set up an infinite looping controller for the dots
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 UI background uses a soft radial or linear subtle gradient to match your screenshot
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7FAFF), // Light soft blue-white top tint
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 📝 1. Top Section: Brand Header & Tagline
              Padding(
                padding: EdgeInsets.only(top:55.h),
                child: Column(
                  children: [
                    // Logo + Text Row (If your logo asset has text, replace with Image.asset)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_work_rounded, // Replace with your exact SVG/Image logo
                          color: const Color(0xFF002270),
                          size: 32.r,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "StayMatch",
                          style: AppStyles.bold28poppins.copyWith(
                            color: const Color(0xFF002270),
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Find Your Perfect Home &\nRoommate with AI",
                      textAlign: TextAlign.center,
                      style: AppStyles.medium14poppins.copyWith(
                        color: AppColors.textColorPrimary.withOpacity(0.8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // 🖼️ 2. Center Section: AI Processing Character Illustration Asset
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                child: SizedBox(
                  height: 260.h,
                  width: double.infinity,
                  child: Image.asset(
                    AppImages.personalizationLoadingPic, // 🌟 Pre-rendered center graphic asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // 🔘 3. Bottom Section: Smooth Moving Dots Loading Indicator & Status Text
              Padding(
                padding: EdgeInsets.only(bottom: 48.h),
                child: Column(
                  children: [
                    // Animated Dot Row
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 6.w,
                          children: List.generate(3, (index) {
                            // Creates a staggered wave delay for each dot based on its index
                            final double delay = index * 0.25;
                            double animValue = _animationController.value - delay;
                            if (animValue < 0) animValue += 1.0;

                            // Map to a clean sinewave translation to move the dots up and down smoothly
                            final double offset = Curves.easeInOut.transform(
                              animValue <= 0.5 ? animValue * 2 : (1.0 - animValue) * 2,
                            );

                            return Transform.translate(
                              offset: Offset(0, -offset * 6.r), // Upward bounce range bound
                              child: Container(
                                width: 7.r,
                                height: 7.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // Middle dot scales darker/lighter dynamically
                                  color: const Color(0xFF002270).withOpacity(
                                    index == 1 ? 0.7 : 0.35,
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    // Loading Status Message Text
                    Text(
                      "PERSONALIZING YOUR EXPERIENCE",
                      style: AppStyles.bold12poppins.copyWith(
                        color: AppColors.textColorSecondary,
                        letterSpacing: 1.2,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}