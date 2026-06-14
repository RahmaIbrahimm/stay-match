import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../core/constants/app_icons.dart';
import 'custom_bottom_nav_button.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key, required this.navigationShell});

  final List<Widget> navBarDestinations = [
    // home
    NavigationDestination(
      icon: CustomBottomNavButton(
        icon: ImageIcon(
          AssetImage(AppIcons.homeIcon),
          color: AppColors.primary,
        ),
      ),
      selectedIcon: CustomBottomNavButton(
        selected: true,
        icon: ImageIcon(
          AssetImage(AppIcons.homeIcon),
          color: AppColors.containerColor,
        ),
      ),
      label: '',
    ),
    // file exchange
    NavigationDestination(
      icon: CustomBottomNavButton(
        icon: ImageIcon(
          AssetImage(AppIcons.folderExchangeIcon),
          size: 24.sp,
          color: AppColors.primary,
        ),
      ),
      selectedIcon: CustomBottomNavButton(
        selected: true,
        icon: ImageIcon(
          AssetImage(AppIcons.folderExchangeIcon),
          color: AppColors.containerColor,
          size: 24.sp,
        ),
      ),
      label: '',
    ),
    // add circle
    NavigationDestination(
      icon: CustomBottomNavButton(
        icon: ImageIcon(
          AssetImage(AppIcons.addCircleIcon),
          size: 24.sp,
          color: AppColors.primary,
        ),
      ),
      selectedIcon: CustomBottomNavButton(
        selected: true,
        icon: ImageIcon(
          AssetImage(AppIcons.addCircleIcon),
          color: AppColors.containerColor,
          size: 24.sp,
        ),
      ),
      label: '',
    ),
    // chat bubble
    NavigationDestination(
      icon: CustomBottomNavButton(
        icon: ImageIcon(
          AssetImage(AppIcons.chatBubbleIcon),
          size: 24.sp,
          color: AppColors.primary,
        ),
      ),
      selectedIcon: CustomBottomNavButton(
        selected: true,
        icon: ImageIcon(
          AssetImage(AppIcons.chatBubbleIcon),
          color: AppColors.containerColor,
          size: 24.sp,
        ),
      ),
      label: '',
    ),
    // profile
    NavigationDestination(
      icon: CustomBottomNavButton(
        icon: ImageIcon(
          AssetImage(AppIcons.profileIcon),
          size: 24.sp,
          color: AppColors.primary,
        ),
      ),
      selectedIcon: CustomBottomNavButton(
        selected: true,
        icon: ImageIcon(
          AssetImage(AppIcons.profileIcon),
          color: AppColors.containerColor,
          size: 24.sp,
        ),
      ),
      label: '',
    ),
    // grid
    NavigationDestination(
      icon: CustomBottomNavButton(
        icon: ImageIcon(
          AssetImage(AppIcons.gridIcon),
          size: 24.sp,
          color: AppColors.primary,
        ),
      ),
      selectedIcon: CustomBottomNavButton(
        selected: true,
        icon: ImageIcon(
          AssetImage(AppIcons.gridIcon),
          color: AppColors.containerColor,
          size: 24.sp,
        ),
      ),
      label: '',
    ),
  ];
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.transparent,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      destinations: navBarDestinations,
      onDestinationSelected: navigationShell.goBranch,
      backgroundColor: Colors.transparent,
      selectedIndex: navigationShell.currentIndex,
    );
  }
}