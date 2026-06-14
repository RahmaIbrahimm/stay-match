import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({super.key, required this.amenities});

  final List<Map<String, dynamic>> amenities;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RPadding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 20.w,
          runSpacing: 12.h,
          alignment: WrapAlignment.start,
          children: amenities.map((item) {

            return SizedBox(
              width: 150.w,
              child: Row(
                spacing: 12.w,
                children: [
                  Icon(item['icon'], color: AppColors.primary, size: 20.sp),
                  Text(
                    item['name'],
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}