import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null )Icon(icon, color: AppColors.primary, size: 22.sp),
        if (icon != null )SizedBox(width: 8.w),
        Text(title, style: AppStyles.bold18poppins),
      ],
    );
  }
}