import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import 'drawer_item.dart';
import 'user_profile_tile.dart';

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.75,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            // --- Header ---
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                AppStrings.myProfile,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF19212C),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Manage your renter identity',
                style: AppStyles.medium14poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: const Divider(color: AppColors.stroke),
            ),
            SizedBox(height: 16.h),

            // --- Menu Items ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerItem(
                    icon: Icons.person_outline,
                    label: 'Personal Info',
                    isSelected: false,
                  ),
                  DrawerItem(
                    icon: Icons.history_outlined, // أيقونة My Booking
                    label: 'My Booking',
                    isSelected: false,
                  ),
                  DrawerItem(
                    icon: Icons.assignment_outlined,
                    label: 'Booking',
                    isSelected: false,
                  ),
                  DrawerItem(
                    icon: Icons.favorite_border,
                    label: 'Saved Matches',
                    isSelected: true, // المختار في الصورة الثانية
                  ),
                  DrawerItem(
                    icon: Icons.grid_view_outlined,
                    label: AppStrings.myProperties,
                    isSelected: false,
                  ),
                  DrawerItem(
                    icon: Icons.list_alt_outlined,
                    label: 'Properties',
                    isSelected: false,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),

            // --- Bottom User Profile ---
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal:12.0),
              child: const UserProfileTile(),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}