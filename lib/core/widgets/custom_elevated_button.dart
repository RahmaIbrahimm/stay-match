import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.backgroundColor,
    this.isLoading = false,
    required this.text,
    this.textColor,
    this.icon,
    required this.onPressed,
    this.textStyle,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final String text;
  final bool isLoading;
  final Widget? icon;
  final VoidCallback? onPressed;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 10,
          horizontal: horizontalPadding ?? 0,
        ),
      ),

      onPressed: onPressed,
      child: isLoading
          ? CircularProgressIndicator(color: AppColors.textColorWhite)
          : Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: (textStyle ?? AppStyles.cardTitle).copyWith(
                    color: textColor ?? AppColors.containerColor,
                  ),
                ),
                if (icon != null) icon!,
              ],
            ),
    );
  }
}