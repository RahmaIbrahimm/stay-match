import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';

import '../../../../widgets/gradient_background.dart';
import 'forget_password_container.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        GradientBackground(),
        ForgetPasswordContainer(size: size),
      ],
    );
  }
}