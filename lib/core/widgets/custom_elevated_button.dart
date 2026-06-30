import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    this.borderRadius,
    this.suffixIcon,
    this.borderColor,
    this.maxLines, this.mainAxisAlignment,  this.elevation = 0,
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
  final double? borderRadius;
  final Widget? suffixIcon;
  final Color? borderColor;
  final int? maxLines;
  final MainAxisAlignment? mainAxisAlignment;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.r ?? 10.r,
          horizontal: horizontalPadding?.r ?? 16.r,
        ),
        shape: borderRadius != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!.r),
              )
            : null,
        minimumSize: (verticalPadding != null || horizontalPadding != null)
            ? Size(0, 0)
            : null,
        elevation: elevation,
      ),
      onPressed: onPressed,
      child: isLoading
          ? CircularProgressIndicator(color: AppColors.textColorWhite)
          : Row(
        mainAxisSize: MainAxisSize.min,
              spacing: 8.w,
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
              children: [
                if (suffixIcon != null) suffixIcon!,
                Flexible(
                  child: Text(
                    text,
                    style: (textStyle ?? AppStyles.medium20poppins).copyWith(
                      color: textColor ?? AppColors.containerColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: maxLines,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (icon != null) icon!,
              ],
            ),
    );
  }
}