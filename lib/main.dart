import 'package:flutter/material.dart';
import 'package:stay_match/core/theme/app_theme.dart';
import 'features/auth/login/presentation/views/login_view.dart';

void main() {
  runApp(StayMatch());
}
class StayMatch extends StatelessWidget {
  const StayMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: LoginView(),
    );
  }
}