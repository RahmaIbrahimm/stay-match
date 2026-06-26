import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../core/constants/app_icons.dart';
import '../../Features/notifications/presentation/manager/notifications_cubit.dart';
import 'custom_bottom_nav_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97.h,
      padding: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withValues(alpha: 0.1),
            width: 1.h,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1. Home
            _buildItem(
              index: 0,
              iconPath: AppIcons.homeIcon,
            ),

            // 2. My Bookings
            _buildItem(
              index: 1,
              iconPath: AppIcons.folderExchangeIcon,
            ),

            // 3. Add Property
            _buildItem(
              index: 2,
              iconPath: AppIcons.addCircleIcon,
            ),

            // 4. Chat Bubble
            _buildItem(
              index: 3,
              iconPath: AppIcons.chatBubbleIcon,
            ),
            BlocBuilder<NotificationsCubit, NotificationsState>(
              buildWhen: (previous, current) => true,
              builder: (context, state) {
                final cubit = context.read<NotificationsCubit>();

                // 1. Pull directly from the primitive variable updated in _markAllReadLocally()
                bool hasUnreadNotifications = cubit.hasUnread;

                // 2. If we are explicitly in a clear success state, force override it to false
                if (state is MarkAllReadSuccess || state is GetUnreadCountSuccess) {
                  hasUnreadNotifications = false;
                }

                bool isSelected = navigationShell.currentIndex == 4;

                return Expanded(
                  child: InkWell(
                    onTap: () => navigationShell.goBranch(4),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Center(
                      child: CustomBottomNavButton(
                        selected: isSelected,
                        icon: ImageIcon(
                          AssetImage(hasUnreadNotifications
                              ? AppIcons.notificationExistIcon
                              : AppIcons.notificationsIcon),
                          size: 24.sp,
                          color: isSelected ? AppColors.containerColor : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            // 6. Profile
            _buildItem(
              index: 5,
              iconPath: AppIcons.profileIcon,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to keep layouts and alignment identical across regular items
  Widget _buildItem({required int index, required String iconPath}) {
    bool isSelected = navigationShell.currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => navigationShell.goBranch(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: CustomBottomNavButton(
            selected: isSelected,
            icon: ImageIcon(
              AssetImage(iconPath),
              size: 24.sp,
              color: isSelected ? AppColors.containerColor : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}