import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import 'login_view_body_bottom_sheet.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: LoginViewBodyBottomSheet(),
        ),
      ],
    );
  }
}