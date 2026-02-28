import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';
import 'package:stay_match/features/auth/data/repos/auth_repo_impl.dart';
import 'package:stay_match/features/auth/verify_email/presentation/views/widgets/verify_email_view_body.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(body: VerifyEmailViewBody()),
    );
  }
}