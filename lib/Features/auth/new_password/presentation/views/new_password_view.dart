import 'package:flutter/material.dart';
import 'package:stay_match/features/auth/new_password/presentation/views/widgets/new_password_view_Body.dart';

class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: const Scaffold(body: NewPasswordViewBody()));
  }
}