import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
class SmallCustomButton extends StatelessWidget {
  const SmallCustomButton({
    super.key,
    required this.onPressed,
    required this.text
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 5),
        elevation: 0,
        minimumSize: Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        text,
        style: AppStyles.semiBold12Poppins.copyWith(
          color: AppColors.textColorWhite,
        ),
      ),
    );
  }
}