import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CompatibilitySection extends StatelessWidget {
  const CompatibilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real compatibility score from API
    const compatibilityScore = 94;

    // TODO: replace with real compatibility items from API
    const items = [
      CompatibilityItemData(
        icon: Icons.check,
        iconBg: Color(0xFFE3F6EA),
        iconColor: Color(0xFF1E9E5C),
        title: 'Quiet Hours',
        description: 'Both prefer quiet after 10 PM.',
      ),
      CompatibilityItemData(
        icon: Icons.check,
        iconBg: Color(0xFFE3F6EA),
        iconColor: Color(0xFF1E9E5C),
        title: 'No Smoking',
        description: 'Ahmed maintains a smoke-free environment.',
      ),
      CompatibilityItemData(
        icon: Icons.info_outline,
        iconBg: Color(0xFFE3ECFB),
        iconColor: Color(0xFF3B6FE0),
        title: 'Pet Policy',
        description: 'Ahmed prefers small pets only.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Compatibility',
                style: AppStyles.semiBold16poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              Text(
                '$compatibilityScore%',
                style: AppStyles.bold16poppins.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: compatibilityScore / 100,
              minHeight: 8.h,
              backgroundColor: AppColors.bgGrey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          SizedBox(height: 16.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: CompatibilityItem(data: item),
            ),
          ),
        ],
      ),
    );
  }
}

class CompatibilityItemData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String description;

  const CompatibilityItemData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}

class CompatibilityItem extends StatelessWidget {
  final CompatibilityItemData data;

  const CompatibilityItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(color: data.iconBg, shape: BoxShape.circle),
          child: Icon(data.icon, size: 16.r, color: data.iconColor),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: AppStyles.semiBold14poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                data.description,
                style: AppStyles.regular12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}