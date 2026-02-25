import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/theme/app_theme.dart';
import 'package:stay_match/features/auth/signup/presentation/views/signup_view.dart';

void main() {
  runApp(StayMatch());
}

class StayMatch extends StatelessWidget {
  const StayMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: SignUpView(),
      ),
    );
  }
}