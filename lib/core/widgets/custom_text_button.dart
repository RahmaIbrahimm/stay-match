import 'package:flutter/material.dart ';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.isUnderlined = true,
    this.textStyle,
    this.isPadded = true,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final bool isUnderlined;
  final TextStyle? textStyle;
  final bool isPadded;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        textStyle: AppStyles.secondary,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: isPadded ? null : MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: (textStyle ?? AppStyles.secondary).copyWith(
          decoration: isUnderlined
              ? TextDecoration.underline
              : TextDecoration.none,
          color: textColor ?? AppColors.primary,
        ),
      ),
    );
  }
}