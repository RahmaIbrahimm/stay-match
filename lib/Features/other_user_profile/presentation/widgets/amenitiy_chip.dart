import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
class AmenityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const AmenityChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.r, color: AppColors.textColorSecondary),
        SizedBox(width: 4.w),
        Text(
          label,
          style: AppStyles.regular12poppins.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
      ],
    );
  }
}