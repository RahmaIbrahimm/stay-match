import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/features/auth/login/presentation/views/widgets/form_section.dart';

class ForgetPasswordContainerBody extends StatelessWidget {
  ForgetPasswordContainerBody({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        Text(
          AppStrings.forgetPassword,
          style: AppStyles.headLine,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.forgetPasswordInstructions,
          style: AppStyles.bodyText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // todo implement validation
        Form(
          key: formKey,
          child: FormSection(
            validator: (val) {},
            hintText: AppStrings.enterYourEmail,
            fieldTitle: AppStrings.emailAddress,
            stroke: false,
            controller: _emailController,
          ),
        ),
        const SizedBox(height: 36),
        // todo implement on pressed logic
        CustomElevatedButton(text: AppStrings.confirmEmail, onPressed: () {}),
      ],
    );
  }
}