import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class TimeLineStep extends StatelessWidget {
  const TimeLineStep({
    super.key,
    required this.num,
    required this.title,
    required this.sub,
    required this.active,
    this.isLast = false,
  });

  final String num;
  final String title;
  final String sub;
  final bool active;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final Color primary = active
        ? const Color(0xFF1A2E63)
        : const Color(0xFFD3E4FE);
    final Color textColor = active ? Colors.white : AppColors.textColorPrimary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: primary,
                child: Text(
                  num,
                  style: AppStyles.bold10poppins.copyWith(color: textColor),
                ),
              ),
            ),
            Container(
              width: 1.5,
              height: !isLast ? 35.h : 10.h,
              color: const Color(0xFFD3E4FE),
            ),
          ],
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.regular16poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
            Text(
              sub,
              style: AppStyles.regular16poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}