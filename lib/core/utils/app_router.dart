import 'package:go_router/go_router.dart';
import 'package:medihome/features/add_medication/presentation/views/add_medication_view.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';
import 'package:medihome/features/authentication/presentation/views/forget_password_view.dart';
import 'package:medihome/features/authentication/presentation/views/login_view.dart';
import 'package:medihome/features/authentication/presentation/views/register_view.dart';
import 'package:medihome/features/home/presentation/views/home_view.dart';
import 'package:medihome/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kSplash = '/spalsh';
  static const String kLogin = '/login';
  static const String kRegister = '/register';
  static const String kHome = '/home';
  static const String kForgetPassword = '/forget-password';
  static const String kAddMedication = '/';

  static final GoRouter routes = GoRouter(
    initialLocation: kSplash,
    routes: [
      GoRoute(
        path: kSplash,
        builder: (context, state) {
          return const SplashView();
        },
      ),
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
          return HomeView(userModel: state.extra as UserModel);
        },
      ),
      GoRoute(
        path: kForgetPassword,
        builder: (context, state) {
          return const ForgetPasswordView();
        },
      ),
      GoRoute(
        path: kAddMedication,
        builder: (context, state) {
          return const AddMedicationView();
        },
      ),
    ],
  );
}
