import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class SharedPropertySectionHeader extends StatelessWidget {
  final IconData? icon;
  final String label;

  const SharedPropertySectionHeader({
    super.key,
    this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(icon, size: 16.r, color: AppColors.textColorPrimary),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppStyles.bold16poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
      ],
    );
  }
}