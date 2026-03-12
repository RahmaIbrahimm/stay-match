import 'package:flutter/material.dart';
import '../../../../widgets/custom_container.dart';
import '../../../../widgets/gradient_background.dart';
import 'reset_password_container_body.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const GradientBackground(),
        CustomContainer(containerBody: ResetPasswordContainerBody()),
      ],
    );
  }
}