import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class CustomBottomNavButton extends StatelessWidget {
  const CustomBottomNavButton({
    super.key,
    required this.icon,
    this.selected = false,
  });

  final Widget icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: selected ? AppColors.primary : Colors.white,
      ),
      child: icon,
    );
  }
}