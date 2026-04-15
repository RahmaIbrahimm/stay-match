import 'package:flutter/material.dart';
import 'package:stay_match/Features/auth/presentation/verify_email/presentation/views/widgets/verify_email_view_body.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Scaffold(body: VerifyEmailViewBody()));
  }
}