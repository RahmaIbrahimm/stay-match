import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../utils/secure_storage_helper.dart';
import '../utils/secure_storage_keys.dart';
import '../utils/service_locator.dart';

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

    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    try {
      // 🌟 Wait for both storage and a clean 2-second minimum delay so the screen doesn't snap away too fast
      final results = await Future.wait([
        getIt.get<SecureStorageHelper>().readFromSecureStorage(key: SecureStorageKeys.tokenKey),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      final String? token = results[0] as String?;

      if (mounted) {
        if (token != null) {
          context.goNamed(AppRouting.homeViewName);
        } else {
          context.goNamed(AppRouting.onboardingName);
        }
      }
    } catch (e) {
      // Fallback safeguard to prevent getting stuck if storage misbehaves
      if (mounted) {
        context.goNamed(AppRouting.onboardingName);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
              Color(0xFFF7FAFF),
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
                padding: EdgeInsets.only(top: 55.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_work_rounded,
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
                    AppImages.personalizationLoadingPic,
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
                          children: List.generate(5, (index) {
                            // Elements 1, 3, 5 are SizedBoxes to handle spacing cleanly without the invalid keyword
                            if (index % 2 != 0) {
                              return SizedBox(width: 6.w);
                            }

                            final int dotIndex = index ~/ 2;
                            final double delay = dotIndex * 0.25;
                            double animValue = _animationController.value - delay;
                            if (animValue < 0) animValue += 1.0;

                            final double offset = Curves.easeInOut.transform(
                              animValue <= 0.5 ? animValue * 2 : (1.0 - animValue) * 2,
                            );

                            return Transform.translate(
                              offset: Offset(0, -offset * 6.r),
                              child: Container(
                                width: 7.r,
                                height: 7.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF002270).withOpacity(
                                    dotIndex == 1 ? 0.7 : 0.35,
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
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