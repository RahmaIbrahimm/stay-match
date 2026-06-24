import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/widgets/app_drawer/main_app_drawer.dart';

class EmptyInbox extends StatelessWidget {
  const EmptyInbox({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init should typically be called in your main.dart
    // but ensuring it's available for this specific UI structure.
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F8),
      endDrawer: MainAppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.containerColor,
        title: Text(
          AppStrings.chats,
          style: AppStyles.bold24poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),

                // Centered Illustration Container
                Center(
                  child: Container(
                    width: 148.w,
                    height: 122.w, // Keeps it a perfect circle
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(99999),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF1A2E6B,
                          ).withValues(alpha: 0.08),
                          blurRadius: 25,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mark_email_unread_rounded,
                      size: 75.sp, // Responsive icon size
                      color: AppColors.primary,
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Title
                Text(
                  'No Messages Yet!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textColorPrimary,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: 16.h),

                // Subtitle
                Text(
                  'Your inbox is currently empty. This is where you\'ll find conversations with property owners and updates about your rental inquiries.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    height: 1.6,
                    color: AppColors.textColorSecondary,
                  ),
                ),

                SizedBox(height: 50.h),

                // Primary Button: Back to Home
                _buildButton(
                  label: 'Back to Home',
                  icon: Icons.home_filled,
                  isPrimary: true,
                  context: context,
                  screenViewName: AppRouting.homeViewName
                ),

                SizedBox(height: 16.h),

                // todo:Secondary Button: Browse Properties
                _buildButton(
                  label: 'Browse Properties',
                  icon: Icons.search,
                  isPrimary: false,
                  context: context,
                  screenViewName:AppRouting.homeViewName
                ),

                // Extra padding at the bottom to ensure comfortable scrolling
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required bool isPrimary,
    required BuildContext context,
    required screenViewName
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0xFF1A2E6B).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          context.goNamed(screenViewName);
        },
        icon: Icon(icon, size: 20.sp),
        label: Text(
          label,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.white,
          foregroundColor: isPrimary ? Colors.white : AppColors.textColorSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
    );
  }
}