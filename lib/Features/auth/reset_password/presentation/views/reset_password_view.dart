import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';
import 'package:stay_match/features/auth/data/repos/auth_repo_impl.dart';
import 'package:stay_match/features/auth/reset_password/presentation/views/widgets/reset_password_view_Body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: ResetPasswordViewBody()));
  }
}