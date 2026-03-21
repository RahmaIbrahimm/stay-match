import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class FilterOptionCard extends StatelessWidget {
  const FilterOptionCard({
    super.key,
    required this.title,
    this.desc,
    required this.icon,
    this.bottomWidget,
    this.isSelected = false,
  });

  final String title;
  final String? desc;
  final Widget icon;
  final Widget? bottomWidget;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
        margin: EdgeInsets.only(left: 8.r, right: 8.r),
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          border:  Border.all(color: isSelected ? AppColors.primary: AppColors.blueGrey) ,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          spacing: 16.h,
          children: [
            Row(
              spacing: 16.w,
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.blueGrey,
                  ),
                  child: icon,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: AppStyles.semiBold14poppins.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
                      ),
                      if (desc != null)
                        TextSpan(
                          text: desc,
                          style: AppStyles.regular12poppins.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (bottomWidget != null) bottomWidget!,
          ],
        ),
      ),
    );
  }
}