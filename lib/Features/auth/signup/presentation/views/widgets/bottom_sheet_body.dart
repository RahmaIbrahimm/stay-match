import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/features/auth/widgets/custom_drop_down_menu.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/constants/app_styles.dart';
import '../../../../../../core/routing/app_routing.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_button.dart';
import '../../../../login/presentation/views/widgets/form_section.dart';

class ButtomSheetBody extends StatelessWidget {
  ButtomSheetBody({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
            validator: validator,
            hintText: AppStrings.enterYourName,
            fieldTitle: AppStrings.name,
            controller: _nameController,
          ),
          const SizedBox(height: 22),
          // info: email
          FormSection(
            validator: validator,
            hintText: AppStrings.enterYourEmail,
            fieldTitle: AppStrings.email,
            suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
            controller: _emailController,
          ),
          const SizedBox(height: 22),
          // info: password
          FormSection(
            validator: validator,
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
            validator: validator,
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
            validator: validator,
            hintText: AppStrings.enterYourAge,
            fieldTitle: AppStrings.age,
            controller: _ageController,
          ),
          const SizedBox(height: 22),
          // info: location
          FormSection(
            validator: validator,
            hintText: AppStrings.enterYourLocation,
            fieldTitle: AppStrings.location,
            controller: _locationController,
          ),
          const SizedBox(height: 22),
          // info: gender
          Text(AppStrings.gender, style: AppStyles.sectionTitle),
          const SizedBox(height: 8),
          CustomDropDownMenu(
            menuItems: AppStrings.genderMenuItems,
            hintText: AppStrings.selectYourGender,
          ),
          const SizedBox(height: 45),
          CustomElevatedButton(
            text: AppStrings.submit,
            onPressed: signupOnPressed,
          ),
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
                onPressed: () {
                  context.pushReplacement(AppRouting.loginView);
                },
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

  void signupOnPressed() {}
  String? validator(value) {}
}