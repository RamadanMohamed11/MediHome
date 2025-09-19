import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/features/authentication/presentation/widgets/custom_button.dart';
import 'package:medihome/features/authentication/presentation/widgets/email_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/widgets/password_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/widgets/tall_bar.dart';
import 'package:medihome/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:medihome/features/authentication/presentation/widgets/language_selection_widget.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
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

  void loginOnPressed() {
    if (formKey.currentState!.validate()) {
      GoRouter.of(context).push(AppRouter.kHome);
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
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.blue,
              period: Duration(seconds: 5),
              child: Text(
                S.of(context).login,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
                Checkbox(value: false, onChanged: (value) {}),
                Text(
                  S.of(context).rememberMe,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
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
                    onPressed: () {},
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
