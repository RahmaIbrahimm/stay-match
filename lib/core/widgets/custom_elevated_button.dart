import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.backgroundColor,
    required this.text,
    this.textColor,
    this.icon, required this.onPressed,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 10),
      ),

      onPressed: onPressed,
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppStyles.cardTitle.copyWith(
              color: textColor ?? AppColors.containerColor,
            ),
          ),
          if(icon != null) icon!,
        ],
      ),
    );
  }
}