import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';
import 'package:stay_match/features/auth/login/presentation/views/widgets/form_section.dart';

class ForgetPasswordContainerBody extends StatelessWidget {
  const ForgetPasswordContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.forgetPassword,style: AppStyles.headLine,textAlign: TextAlign.center,),
        const SizedBox(height: 16,),
        Text(AppStrings.forgetPasswordInstructions,style: AppStyles.bodyText,textAlign: TextAlign.center,),
        const SizedBox(height: 24,),
        // todo implement validation
        FormSection(validator: (val){}, hintText: AppStrings.enterYourEmail, fieldTitle: AppStrings.emailAddress,stroke: false,),
        const SizedBox(height: 36,),
        // todo implement on pressed logic
        CustomElevatedButton(text: AppStrings.confirmEmail, onPressed: (){})
      ],
    );
  }
}