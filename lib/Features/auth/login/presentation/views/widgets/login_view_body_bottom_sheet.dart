import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';

import '../../../../widgets/form_section.dart';
import 'divider_between_login_buttons.dart';

class LoginViewBodyBottomSheet extends StatelessWidget {
  LoginViewBodyBottomSheet({super.key});

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: ListView(
        children: [
          const SizedBox(height: 33),
          // todo: implement validator email
          FormSection(
            validator: (value) {},
            hintText: AppStrings.enterYourEmail,
            fieldTitle: AppStrings.email,
            suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
            controller: _emailController,
          ),
          const SizedBox(height: 37),
          // todo: implement validator password
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
          //TODO: on pressed implementation
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextButton(
              onPressed: () {},
              text: AppStrings.forgetPasswordQuestion,
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              text: AppStrings.login,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 15),
          DividerBetweenLoginButtons(size: size),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              text: AppStrings.loginWithGoogle,
              backgroundColor: AppColors.secondary,
              textColor: AppColors.backgroundColor,
              icon: Brand(Brands.google, size: 20),
              onPressed: () {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.dontHaveAnAccount),
              // TODO: implement on pressed
              CustomTextButton(
                onPressed: () {},
                text: AppStrings.signUp,
                textColor: AppColors.secondary,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}