import 'package:flutter/material.dart';
import 'package:stay_match/features/auth/signup/presentation/views/widgets/signup_view_body.dart';


class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: const SignUpViewBody()));
  }
}