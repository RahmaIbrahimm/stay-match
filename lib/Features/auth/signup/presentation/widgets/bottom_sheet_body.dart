import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../widgets/form_section.dart';
class ButtomSheetBody extends StatelessWidget {
  const ButtomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 30),
      children: [
        // todo: implement validators
        // info: name
        FormSection(
          validator: (val) {},
          hintText: AppStrings.enterYourName,
          fieldTitle: AppStrings.name,
        ),
        const SizedBox(height: 22),
        // info: email
        FormSection(
          validator: (value) {},
          hintText: AppStrings.enterYourEmail,
          fieldTitle: AppStrings.email,
          suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
        ),
        const SizedBox(height: 22),
        // info: password
        FormSection(
          validator: (val) {},
          hintText: AppStrings.enterYourPassword,
          fieldTitle: AppStrings.password,
        ),
        const SizedBox(height: 22),
        // info: confirm password
        FormSection(
          validator: (val) {},
          hintText: AppStrings.enterYourPassword,
          fieldTitle: AppStrings.confirmPassword,
        ),
        const SizedBox(height: 22),
        // info: age
        FormSection(
          validator: (val) {},
          hintText: AppStrings.enterYourAge,
          fieldTitle: AppStrings.age,
        ),
        const SizedBox(height: 22),
        // info: location
        FormSection(
          validator: (value) {},
          hintText: AppStrings.enterYourLocation,
          fieldTitle: AppStrings.location,
        ),
        const SizedBox(height: 22),
        // info: gender
        FormSection(
          validator: (value) {},
          hintText: AppStrings.enterYourGender,
          fieldTitle: AppStrings.gender,
        ),
        const SizedBox(height: 45),
        CustomElevatedButton(text: AppStrings.submit, onPressed: () {}),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.alreadyHaveAnAccount,
              style: AppStyles.secondary.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
            CustomTextButton(
              onPressed: () {},
              text: AppStrings.login,
              textColor: AppColors.secondary,
            ),
          ],
        ),
        const SizedBox(height: 45),
      ],
    );
  }
}