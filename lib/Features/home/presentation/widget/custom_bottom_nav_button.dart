import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class CustomBottomNavButton extends StatelessWidget {
  const CustomBottomNavButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: AppColors.stroke, width: 2),
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        iconSize: 24,
      ),
      color: AppColors.primary,
      icon: icon,
    );
  }
}