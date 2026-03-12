import 'package:go_router/go_router.dart';
import 'package:stay_match/features/home/presentation/views/home_view.dart';
import '../../features/auth/presentation/forget_password/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/login/presentation/views/login_view.dart';
import '../../features/auth/presentation/reset_password/presentation/views/reset_password_view.dart';
import '../../features/auth/presentation/signup/presentation/views/signup_view.dart';
import '../../features/auth/presentation/verify_email/presentation/views/verify_email_view.dart';
import '../../features/properties/rooms/presentation/views/find_room_view.dart';

class AppRouting {
  // auth
  static const loginView = '/';
  static const signupView = '/signupView';
  static const forgetPasswordView = '/forgetPasswordView';
  static const verifyEmailView = '/verifyEmailView';
  static const resetPasswordView = '/resetPasswordView';
  static const findRoomView = '/findRoomView';

  // home
  static const homeView = '/homeView';

  static final router = GoRouter(
    initialLocation: findRoomView,
    routes: [
      GoRoute(path: loginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: signupView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: forgetPasswordView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: verifyEmailView,
        builder: (context, state) => const VerifyEmailView(),
      ),
      GoRoute(
        path: resetPasswordView,
        builder: (context, state) => const ResetPasswordView(),
      ),
      GoRoute(path: homeView, builder: (context, state) => const HomeView()),
      GoRoute(path: findRoomView, builder: (context, state) => const FindRoomView()),
    ],
  );
}