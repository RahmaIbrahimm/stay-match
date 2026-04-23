import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

import '../../../../core/constants/app_strings.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: Container(),
      backgroundColor: Colors.white,
      pinned: true,
      centerTitle: true,
      shadowColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,

      flexibleSpace: CustomTextFormField(
        hasShadow: false,
        suffixIcon: Icon(
          Icons.search,
          color: AppColors.textColorSecondary,
          size: 20.sp,
        ),
        strokeWidth: 1.r,
        borderRadius: 12.r,
        strokeColor: AppColors.textColorSecondary,
        verticalPadding: 8.r,
        hintText: AppStrings.search,
        validator: (v) {
          return null;
        },

        controller: TextEditingController(),
      ),

      // todo: implement search logic :)
    );
  }
}