import 'package:flutter/material.dart ';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text, this.textColor,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          overlayColor: Colors.transparent,
          textStyle: AppStyles.secondary,
          padding: EdgeInsets.zero
      ),
      onPressed: onPressed,
      child: Text(text, style: AppStyles.secondary.copyWith(
          decoration: TextDecoration.underline,
          color: textColor ?? AppColors.primary),),
    );
  }
}