import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/core/widgets/custom_button.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/custom_text_widget.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/email_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/password_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/tall_bar.dart';
import 'package:medihome/generated/l10n.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/language_selection_widget.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _loadUserPreferences();
  }

  void _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final rememberMe = prefs.getBool('rememberMe') ?? false;

    if (rememberMe && email != null && password != null) {
      setState(() {
        emailController.text = email;
        passwordController.text = password;
        _rememberMe = rememberMe;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void emailOnSaved(String? value) {
    emailController.text = value ?? '';
  }

  void passwordOnSaved(String? value) {
    passwordController.text = value ?? '';
  }

  void loginOnPressed() async {
    if (!mounted) return;

    if (formKey.currentState!.validate()) {
      _handleRememberMe();
      final router = GoRouter.of(context);
      await BlocProvider.of<AuthenticationCubit>(context)
          .signIn(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((value) {
            if (value != null) {
              router.pushReplacement(AppRouter.kHome, extra: value);
            }
          });
    }
  }

  void _handleRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CustomTextWidget(text: S.of(context).login),
            Text(
              S.of(context).enterYourEmailAndPasswordToLogIn,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 24),
            EmailTextFormField(
              emailController: emailController,
              onSavedMethod: emailOnSaved,
            ),
            SizedBox(height: 12),
            PasswordTextFormField(
              passwordController: passwordController,
              onSavedMethod: passwordOnSaved,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                ),
                Text(
                  S.of(context).rememberMe,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kForgetPassword);
                  },
                  child: Text(
                    S.of(context).forgotPassword,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: S.of(context).login,
                    onPressed: loginOnPressed,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: TallBar(isRight: true)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    S.of(context).or,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Expanded(child: TallBar(isRight: false)),
              ],
            ),
            SizedBox(height: 24),

            /* Gmail Login */
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: S.of(context).loginWithGmail,
                    onPressed: () async {
                      if (!mounted) return;

                      final userModel =
                          await BlocProvider.of<AuthenticationCubit>(
                            context,
                          ).signInWithGoogle(context);

                      if (userModel != null && mounted) {
                        final router = GoRouter.of(context);
                        if (mounted) {
                          router.push(AppRouter.kHome, extra: userModel);
                        }
                      }
                    },
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).dontHaveAccount,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      // push to the register screen using go_router

                      GoRouter.of(context).push(AppRouter.kRegister);
                    },
                    child: Text(
                      S.of(context).register,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const LanguageSelectionWidget(),
          ],
        ),
      ),
    );
  }
}
