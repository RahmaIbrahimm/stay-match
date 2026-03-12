import 'package:flutter/material.dart';
import 'package:stay_match/features/auth/presentation/reset_password/presentation/views/widgets/reset_password_view_Body.dart';

import '../../../../../../core/constants/app_colors.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor:AppColors.primary,body: ResetPasswordViewBody()));
  }
}