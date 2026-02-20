import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/features/auth/widgets/form_section.dart';

import '../../../../../../core/constants/app_styles.dart';

class NewPasswordContainerBody extends StatelessWidget {
  NewPasswordContainerBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            AppStrings.newPassword,
            style: AppStyles.headLine.copyWith(color: AppColors.textColorPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.pleaseWriteNewPass,
            style: AppStyles.cardTitle.copyWith(
              color: AppColors.textColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          FormSection(
            validator: (val) {},
            hintText: AppStrings.enterYourNewPass,
            fieldTitle: AppStrings.newPassword,
            suffixIcon: Icon(
              Icons.remove_red_eye_outlined,
              color: AppColors.primary,
            ),
            controller: _newPasswordController,
          ),
          const SizedBox(height: 28),
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourNewPass,
            fieldTitle: AppStrings.confirmPassword,
            suffixIcon: Icon(
              Icons.remove_red_eye_outlined,
              color: AppColors.primary,
            ),
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 40),
          CustomElevatedButton(text: AppStrings.confirmCode, onPressed: () {}),
        ],
      ),
    );
  }
}