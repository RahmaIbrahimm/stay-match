import 'package:flutter/material.dart%20';
import 'package:stay_match/features/auth/widgets/custom_bottom_sheet.dart';

import '../views/widgets/bottom_sheet_body.dart';
import '../views/widgets/signup_header.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 45),
        Padding(padding: const EdgeInsets.all(16.0), child: SignUpHeader()),
        const SizedBox(height: 20),
        Expanded(child: CustomBottomSheet(sheetBody:  ButtomSheetBody())),
      ],
    );
  }
}