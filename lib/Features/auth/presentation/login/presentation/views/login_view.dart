import 'package:flutter/material.dart';
import 'package:stay_match/features/auth/presentation/login/presentation/views/widgets/login_view_body.dart';

import '../../../../../../core/constants/app_colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: AppColors.primary,body: LoginViewBody()),
    );
  }
}