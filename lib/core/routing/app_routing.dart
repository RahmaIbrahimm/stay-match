import 'package:go_router/go_router.dart';
import 'package:stay_match/features/auth/login/presentation/views/login_view.dart';
import 'package:stay_match/features/auth/signup/presentation/views/signup_view.dart';

abstract class AppRouting {
  static const loginView ='/';
  static const signupView ='/signupView';

  final router = GoRouter(
  routes: [
    GoRoute(path: loginView, builder: (context, state) => const LoginView(),),
    GoRoute(path: signupView,builder: (context, state) => const SignUpView(),),
  ]
  );
}