import 'package:flutter/material.dart';

import '../../../widgets/custom_bottom_sheet.dart';
import 'login_view_body_bottom_sheet.dart';
import 'login_view_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginViewHeader(),
        const SizedBox(height: 20),
        Expanded(
          child: CustomBottomSheet(sheetBody: LoginViewBodyBottomSheet())
        ),
      ],
    );
  }
}