import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../widgets/reset_password_view_Body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: BackButton(onPressed: (){if(context.canPop()) context.pop();},),
        ),
        backgroundColor: AppColors.primary,
        body: ResetPasswordViewBody(),
      ),
    );
  }
}