import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';


class AuthHeaderText extends StatelessWidget {
  const AuthHeaderText({
    super.key, required this.greeting, required this.title,
  });
  final String greeting;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppStyles.bold28poppins.copyWith(
              color: AppColors.textColorWhite,
            ),
          ),
        ),
        Text(
          greeting,
          style: AppStyles.semibold24poppins.copyWith(
            color: AppColors.textColorWhite,
          ),
        ),
      ],
    );
  }
}