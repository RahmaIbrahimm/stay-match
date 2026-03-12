import 'package:flutter/material.dart';
import '../../../widgets/gradient_background.dart';
import 'forget_password_container.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        GradientBackground(),
        ForgetPasswordContainer(size: size),
      ],
    );
  }
}