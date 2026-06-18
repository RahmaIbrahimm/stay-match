import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class DrawerItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? widgetIcon;
  const DrawerItem({
    super.key,
    this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,  this.widgetIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Brand Color
    const Color primaryBlue = Color(0xFF182E6E);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        // Light background highlight for the selected item
        color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: [
          // The vertical indicator on the far left
          if (isSelected)
            Positioned(
              left: 0,
              top: 10.h,
              bottom: 10.h,
              child: Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ListTile(
            onTap: onTap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            leading: icon!= null ?  Icon(
              icon,
              size: 22.sp,
              color: isSelected ? primaryBlue : const Color(0xFF2E3E5C),
            ):widgetIcon,
            title: Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryBlue : const Color(0xFF2E3E5C),
                fontSize: 15.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}