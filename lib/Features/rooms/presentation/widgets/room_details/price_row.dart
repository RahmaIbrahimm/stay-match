import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final String value;

  const PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.regular14poppins.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
        Text(
          value,
          style: AppStyles.semiBold14poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
      ],
    );
  }
}