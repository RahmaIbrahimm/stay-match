import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class Apartmenthelper {
  static Widget buildFilterPrompt({
    required String titleText,
    required String prompt,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: titleText,
              style: AppStyles.semiBold16poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
            TextSpan(
              text: prompt,
              style: AppStyles.regular18poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}