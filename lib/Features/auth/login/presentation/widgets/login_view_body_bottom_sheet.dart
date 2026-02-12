import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../widgets/form_section.dart';

class LoginViewBodyBottomSheet extends StatelessWidget {
  const LoginViewBodyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 33),
        FormSection(
          validator: (value) {},
          hintText:AppStrings.enterYourEmail ,
          fieldTitle:  AppStrings.email,
        ),
        SizedBox(height: 37,),
        FormSection(
          validator: (value) {},
          hintText: AppStrings.enterYourPassword ,
          fieldTitle:AppStrings.password ,
        ),
      ],
    );
  }
}