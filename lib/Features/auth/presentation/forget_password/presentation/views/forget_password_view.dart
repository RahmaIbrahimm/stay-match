import 'package:flutter/material.dart%20';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: BackButton(onPressed: (){if(context.canPop()) context.pop();}, color: Colors.white,),
          elevation: 0,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,

        ),
extendBodyBehindAppBar: true,

        backgroundColor: AppColors.primary,
        body: const ForgetPasswordViewBody(),
      ),
    );
  }
}