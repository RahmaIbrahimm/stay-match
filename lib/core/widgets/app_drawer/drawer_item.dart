import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';


class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const DrawerItem({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF182E6E);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withValues(alpha: 0.1): Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: [
          // الـ Indicator الأزرق اللي على الشمال
          if (isSelected)
            Positioned(
              left: 0,
              top: 8.h,
              bottom: 8.h,
              child: Container(
                width: 4.w,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: Icon(
              icon,
              size: 22.sp,
              color: isSelected ? primaryColor : const Color(0xFF2E3E5C),
            ),
            title: Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryColor : const Color(0xFF2E3E5C),
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