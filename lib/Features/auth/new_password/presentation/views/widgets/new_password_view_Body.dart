import 'package:flutter/material.dart';
import 'package:stay_match/features/auth/widgets/custom_container.dart';
import 'package:stay_match/features/auth/widgets/gradient_background.dart';

import 'new_password_container_body.dart';

class NewPasswordViewBody extends StatelessWidget {
  const NewPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const GradientBackground(),
        CustomContainer(containerBody: NewPasswordContainerBody()),
      ],
    );
  }
}