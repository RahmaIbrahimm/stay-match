import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class SmallCustomButton extends StatelessWidget {
  const SmallCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
  });

  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 5.r),
        elevation: 0,
        minimumSize: Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),

      child: Text(
        text,
        style: (textStyle ?? AppStyles.semiBold12poppins).copyWith(
          color: AppColors.textColorWhite,
        ),
      ),
    );
  }
}