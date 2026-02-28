import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/theme/app_theme.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';
import 'package:stay_match/features/auth/data/repos/auth_repo_impl.dart';

import 'core/routing/app_routing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepoImpl>())),
    ],
    child: StayMatch(),
  ));
}

class StayMatch extends StatelessWidget {
  StayMatch({super.key});

  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: AppRouting.router,
    );
  }
}