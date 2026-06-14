import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class BuildFeature extends StatelessWidget {
  const BuildFeature({
    super.key,
    this.size,
    required this.icon,
    required this.text,
  });

  final int? size;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: size != null ? size?.sp : 24.sp,
        ),
        Text(
          text,
          style: AppStyles.medium10poppins.copyWith(
            color: AppColors.textColorSecondary,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}