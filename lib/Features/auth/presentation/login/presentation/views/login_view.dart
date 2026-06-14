import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: LoginViewBody(),
      ),
    );
  }
}