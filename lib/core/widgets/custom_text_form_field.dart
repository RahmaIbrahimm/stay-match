import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../constants/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.validator,
    this.stroke = true,
    required this.controller,
    this.isObscure = false,
    this.strokeWidth,
    this.horizontalPadding,
    this.verticalPadding,
    this.hintStyle,
    this.enabled = true

  });

  final String? Function(String?) validator;
  final String hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final bool stroke;
  final TextEditingController controller;
  final bool isObscure;
  final double? strokeWidth;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppColors.boxShadow,
        borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: enabled,
          hintStyle:
              hintStyle ??
              AppStyles.caption.copyWith(color: AppColors.textColorSecondary),
          border: buildOutlineInputBorder(),
          // TODO: add borders for each case
          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: stroke ? Colors.red : Colors.transparent,
              width: strokeWidth ?? 2,
            ),
          ),
          enabledBorder: buildOutlineInputBorder(),
          focusColor: AppColors.primary,
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.primary,
          fillColor: AppColors.containerColor,
          filled: true,
        ),
        validator: validator,
        controller: controller,

      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: stroke ? AppColors.primary : Colors.transparent,
        width: strokeWidth ?? 2,
      ),
    );
  }
}