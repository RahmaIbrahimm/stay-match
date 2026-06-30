import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart'; // Assuming your routes are here

import 'drawer_item.dart';
import 'user_profile_tile.dart';

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});

  /// Helper method to close drawer and navigate
  void _onItemTapped(BuildContext context, String routeName,
      {bool isPush = false}) {
    if(isPush) {
      context.pushNamed(routeName);
      return;
    }

    context.pop(); // Always close the drawer first
    context.goNamed(routeName); // Navigate to the page

  }

  @override
  Widget build(BuildContext context) {
    // This gets the current active path from GoRouter
    final String currentRoute = GoRouterState.of(context).matchedLocation;

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.myProfile,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF19212C),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Manage your renter identity',
                    style: AppStyles.medium14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            const Divider(color: AppColors.stroke, indent: 24, endIndent: 24),
            SizedBox(height: 16.h),

            // --- Menu Items ---
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerItem(
                    icon: Icons.person_outline,
                    label: 'Personal Info',
                    isSelected: currentRoute.contains(AppRouting.profilePath),
                    onTap: () => _onItemTapped(context, AppRouting.profileName),
                  ),
                  DrawerItem(
                    icon: Icons.history_outlined,
                    label: 'Booking Requests',
                    isSelected: currentRoute.contains(AppRouting.hostBookingsPath),
                    onTap: () => _onItemTapped(context, AppRouting.hostBookingsName),
                  ),
                  DrawerItem(
                    icon: Icons.favorite_border,
                    label: 'Saved Properties',
                    isSelected: currentRoute.contains(AppRouting.savedPropertiesPath),
                    onTap: () => _onItemTapped(context, AppRouting.savedPropertiesName),
                  ),
                  DrawerItem(
                    icon: Icons.grid_view_outlined,
                    label: AppStrings.myProperties,
                    isSelected: currentRoute.contains(AppRouting.myPropertiesPath),
                    onTap: () => _onItemTapped(context, AppRouting.myPropertiesName),
                  ),
                  DrawerItem(
                    widgetIcon: ImageIcon(AssetImage(AppIcons.chatbotIcon)),
                    label: AppStrings.chatbot,
                    isSelected: currentRoute.contains(AppRouting.chatbotPath),
                    onTap: () => _onItemTapped(context, AppRouting.chatbotName,isPush: true),
                  ),
                ],
              ),
            ),

            // --- Bottom Section ---
            const Divider(color: AppColors.stroke),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
              child: const UserProfileTile(),
            ),
          ],
        ),
      ),
    );
  }
}