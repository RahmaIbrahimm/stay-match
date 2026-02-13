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
  });

  final String? Function(String?) validator;
  final String hintText;
  final Widget? suffixIcon;
  final bool stroke;

  @override
  Widget build(BuildContext context) {
    var boxShadow = [
      BoxShadow(
        color: AppColors.shadowColor,
        offset: Offset(5, 5),
        blurRadius: 5,
        spreadRadius: 2,
      ),
    ];

    return Container(
      decoration: BoxDecoration(boxShadow: boxShadow),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.caption.copyWith(
            color: AppColors.textColorSecondary,
          ),
          border: buildOutlineInputBorder(),
          // TODO: add borders for each case
          // errorBorder: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          focusColor: AppColors.primary,
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.primary,
          fillColor: AppColors.containerColor,
          filled: true,
        ),
        validator: validator,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: stroke ? AppColors.primary : Colors.transparent,
        width: 2,
      ),
    );
  }
}