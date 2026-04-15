import 'package:flutter/material.dart%20';
import 'package:stay_match/core/constants/app_strings.dart';
import '../../../../widgets/auth_header.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import 'bottom_sheet_body.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AuthHeaderText(
            greeting: AppStrings.signUpGreeting,
            title: AppStrings.signUpTitle,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: CustomBottomSheet(sheetBody: BottomSheetBody())),
      ],
    );
  }
}