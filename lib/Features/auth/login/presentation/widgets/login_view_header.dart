import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
class LoginViewHeader extends StatelessWidget {
  const LoginViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AppImages.loginDecorLeft, scale: 1.2 ,),
            Image.asset(AppImages.loginDecorRight, scale: 1.2),
          ],
        ),
        Positioned(
          bottom: 1,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.login,
                  style: AppStyles.headLine.copyWith(
                    color: AppColors.textColorWhite,
                  ),
                ),
              ),
              Text(
                AppStrings.welcomeBack,
                style: AppStyles.sectionTitle.copyWith(
                  color: AppColors.textColorWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}