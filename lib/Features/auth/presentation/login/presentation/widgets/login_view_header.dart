import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_images.dart';
import '../../../../../../../core/constants/app_strings.dart';
import '../../../widgets/auth_header.dart';

class LoginViewHeader extends StatelessWidget {
  const LoginViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AppImages.loginDecorLeft, scale: 1.2 ,),
            Image.asset(AppImages.loginDecorRight, scale: 1.2),
          ],
        ),
        Positioned(
          bottom: 1,
          left: 16,
          child: AuthHeaderText(greeting: AppStrings.loginGreeting, title: AppStrings.login,),
        ),
      ],
    );
  }
}