import 'package:flutter/material.dart';
import 'package:stay_match/features/auth/verify_email/presentation/views/widgets/verify_email_container_body.dart';
import 'package:stay_match/features/auth/widgets/custom_container.dart';
import 'package:stay_match/features/auth/widgets/gradient_background.dart';

class VerifyEmailViewBody extends StatelessWidget {
  const VerifyEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
alignment: Alignment.center,
      children: [
        GradientBackground(),
        CustomContainer(containerBody: VerifyEmailContainerBody()),
      ],
    ) ;
  }
}