import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class DurationSelector extends StatelessWidget {
  const DurationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Move In',
                  style: AppStyles.medium15poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
                // TextSpan(
                //   text: 'Move In',
                //   style: AppStyles.medium15poppins.copyWith(color: AppColors.textColorPrimary),
                // ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded),
          Container(height: 55.h, width: 1, color: Colors.black),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Duration',
                  style: AppStyles.medium15poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}