import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/constants/app_styles.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_button.dart';
import '../../../../login/presentation/views/widgets/form_section.dart';

class ButtomSheetBody extends StatelessWidget {
  ButtomSheetBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.only(top: 30),
        children: [
          // todo: implement validators
          // info: name
          FormSection(
            validator: (val) {},
            hintText: AppStrings.enterYourName,
            fieldTitle: AppStrings.name,
            controller: _nameController,
          ),
          const SizedBox(height: 22),
          // info: email
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourEmail,
            fieldTitle: AppStrings.email,
            suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
            controller: _emailController,
          ),
          const SizedBox(height: 22),
          // info: password
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourPassword,
            fieldTitle: AppStrings.password,
            suffixIcon: Icon(
              Icons.remove_red_eye_outlined,
              color: AppColors.primary,
            ),
            controller: _passwordController,
          ),
          const SizedBox(height: 22),
          // info: confirm password
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourPassword,
            fieldTitle: AppStrings.confirmPassword,
            suffixIcon: Icon(
              Icons.remove_red_eye_outlined,
              color: AppColors.primary,
            ),
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 22),
          // info: age
          FormSection(
            validator: (val) {},
            hintText: AppStrings.enterYourAge,
            fieldTitle: AppStrings.age,
          controller: _ageController,
          ),
          const SizedBox(height: 22),
          // info: location
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourLocation,
            fieldTitle: AppStrings.location,
            controller: _locationController,
          ),
          const SizedBox(height: 22),
          // info: gender
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourGender,
            fieldTitle: AppStrings.gender,
            controller: _genderController,
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
      ),
    );
  }
}