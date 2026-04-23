import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class CustomBottomNavButton extends StatelessWidget {
  const CustomBottomNavButton({
    super.key,
    required this.icon,
    this.selected = false,
  });

  final Widget icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke, width: 2.w),
        borderRadius: BorderRadius.circular(12.r),
        color: selected ? AppColors.primary : Colors.white,
      ),
      child: icon,
    );
  }
}