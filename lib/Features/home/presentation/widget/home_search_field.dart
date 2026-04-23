import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.medium10poppins,

      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(minHeight: 20.r, minWidth: 20.r),
        isDense: true,
        border: OutlineInputBorder(
          gapPadding: 4,
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary, width: 0.5),
        ),
        contentPadding: EdgeInsetsGeometry.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        suffixIcon: Icon(
          Icons.search,
          color: AppColors.textColorSecondary,
          size: 16.sp,
        ),
        hintText: AppStrings.searchHome,
        hintStyle: AppStyles.medium10poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      ),
    );
  }
}