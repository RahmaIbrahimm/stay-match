import 'package:flutter/material.dart%20';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/features/auth/forget_password/presentation/views/widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: const ForgetPasswordViewBody()),
    );
  }
}