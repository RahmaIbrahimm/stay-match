import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_toggle_switch.dart';
class ProfileToggleTile extends StatelessWidget {
  const ProfileToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isOn,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool isOn;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.fieldFillColor, // The light grey-blue from your image
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24.sp),
          SizedBox(width: 16.w),
          Text(
            title,
            style: AppStyles.medium14poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          const Spacer(),
          CustomToggleSwitch(
            current: isOn,
            onTap: onChanged,
          ),
        ],
      ),
    );
  }
}