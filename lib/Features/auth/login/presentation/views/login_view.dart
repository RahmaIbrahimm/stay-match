import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/features/auth/login/presentation/views/widgets/login_view_body.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/manager/auth_cubit.dart';
import '../../../data/repos/auth_repo_impl.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
          child: LoginViewBody(),
        ),
      ),
    );
  }
}