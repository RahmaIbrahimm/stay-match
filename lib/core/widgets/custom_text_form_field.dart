import 'package:flutter/material.dart';
import 'package:stay_match/core/utils/app_colors.dart';
import 'package:stay_match/core/utils/app_styles.dart';

import '../utils/app_icons.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, required this.hintText});

  late String hintText;
  late Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hint: Text(
          hintText,
          style: AppStyles.caption.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
        border: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusColor: AppColors.primary,
        suffixIcon: Image.asset(AppIcons.emailIcon, width: 20, height: 20),
        suffixIconColor: AppColors.primary,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    );
  }
}