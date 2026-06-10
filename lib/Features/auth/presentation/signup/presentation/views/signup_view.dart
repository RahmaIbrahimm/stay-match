import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: const SignUpViewBody(),
      ),
    );
  }
}