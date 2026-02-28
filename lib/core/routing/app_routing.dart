import 'package:go_router/go_router.dart';
import 'package:stay_match/features/auth/login/presentation/views/login_view.dart';
import 'package:stay_match/features/auth/new_password/presentation/views/reset_password_view.dart';
import 'package:stay_match/features/auth/signup/presentation/views/signup_view.dart';
import '../../features/auth/forget_password/presentation/views/forget_password_view.dart';
import '../../features/auth/verify_email/presentation/views/verify_email_view.dart';

class AppRouting {
  static const loginView ='/';
  static const signupView ='/signupView';
  static const forgetPasswordView ='/forgetPasswordView';
  static const verifyEmailView ='/verifyEmailView';
  static const newPasswordView ='/newPasswordView';

  static final router = GoRouter(
  routes: [
    GoRoute(path: loginView, builder: (context, state) => const LoginView(),),
    GoRoute(path: signupView,builder: (context, state) => const SignUpView(),),
    GoRoute(path: forgetPasswordView,builder: (context, state) => const ForgetPasswordView(),),
    GoRoute(path: verifyEmailView,builder: (context, state) => const VerifyEmailView(),),
    GoRoute(path: newPasswordView,builder: (context, state) => const ResetPasswordView(),),
  ]
  );
}