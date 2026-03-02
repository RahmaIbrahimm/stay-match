import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';
import 'package:stay_match/features/auth/data/repos/auth_repo_impl.dart';
import 'package:stay_match/features/auth/forget_password/presentation/views/widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: AppColors.primary,body: const ForgetPasswordViewBody()),
    );
  }
}