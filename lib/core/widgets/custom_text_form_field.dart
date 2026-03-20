import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    this.enabled = true,
    this.strokeColor,
    this.borderRadius,
    this.hasShadow = true,
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
  final Color? strokeColor;
  final double? borderRadius;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: hasShadow ? AppColors.boxShadow : null,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: enabled,
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding?.r ?? 16.r,
            horizontal: horizontalPadding?.r ?? 12.r,
          ),
          hintStyle:
              hintStyle ??
              AppStyles.regular12poppins.copyWith(color: AppColors.textColorSecondary),
          border: buildOutlineInputBorder(),
          // TODO: add borders for each case
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: stroke ? Colors.red : Colors.transparent,
              width: strokeWidth?.r ?? 2.r,
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
      borderRadius: BorderRadius.circular(borderRadius?.r ?? 15.r),
      borderSide: BorderSide(
        color: stroke ? strokeColor ?? AppColors.primary : Colors.transparent,
        width: strokeWidth?.r ?? 2.r,
      ),
    );
  }
}