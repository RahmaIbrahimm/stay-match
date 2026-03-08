import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../core/constants/app_styles.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.login,
          style: AppStyles.headLine.copyWith(color: AppColors.textColorWhite),
        ),
        Text(
          AppStrings.loginGreeting,
          style: AppStyles.sectionTitle.copyWith(
            color: AppColors.textColorWhite,
          ),
        ),
      ],
    );
  }
}