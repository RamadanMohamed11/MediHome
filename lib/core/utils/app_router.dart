import 'package:go_router/go_router.dart';
import 'package:medihome/features/authentication/presentation/views/forget_password_view.dart';
import 'package:medihome/features/authentication/presentation/views/login_view.dart';
import 'package:medihome/features/authentication/presentation/views/register_view.dart';
import 'package:medihome/features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const String kLogin = '/';
  static const String kRegister = '/register';
  static const String kHome = '/home';
  static const String kForgetPassword = '/forget-password';

  static final GoRouter routes = GoRouter(
    initialLocation: kLogin,
    routes: [
      GoRoute(
        path: kLogin,
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: kRegister,
        builder: (context, state) {
          return const RegisterView();
        },
      ),
      GoRoute(
        path: kHome,
        builder: (context, state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: kForgetPassword,
        builder: (context, state) {
          return const ForgetPasswordView();
        },
      ),
    ],
  );
}
