import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';


class RequirementCell extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const RequirementCell({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Color(0xffDBE1FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.r, color: AppColors.primary),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppStyles.semiBold12poppins.copyWith(
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppStyles.semiBold14poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}