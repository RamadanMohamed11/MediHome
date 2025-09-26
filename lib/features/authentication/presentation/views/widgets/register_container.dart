import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/custom_text_widget.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/email_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/name_text_field.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/password_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/tall_bar.dart';
import 'package:medihome/generated/l10n.dart';

class RegisterContainer extends StatefulWidget {
  const RegisterContainer({super.key});

  @override
  State<RegisterContainer> createState() => _RegisterContainerState();
}

class _RegisterContainerState extends State<RegisterContainer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> registerOnPressed() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        await BlocProvider.of<AuthenticationCubit>(context).signUp(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          context: context,
        );

        if (mounted) {
          GoRouter.of(context).pop();
        }
      }
    }

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
            CustomTextWidget(text: S.of(context).register),
            Text(
              S.of(context).enterYourNameEmailAndPasswordToRegister,
              textAlign: TextAlign.center,

              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 24),
            NameTextField(
              nameController: nameController,
              onSavedMethod: nameOnSaved,
            ),
            SizedBox(height: 12),
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
                Expanded(
                  child: CustomButton(
                    buttonText: S.of(context).register,
                    onPressed: registerOnPressed,
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
                    S.of(context).alreadyHaveAccount,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      // push to the register screen using go_router

                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      S.of(context).login,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void nameOnSaved(String? value) {
    nameController.text = value ?? '';
  }

  void emailOnSaved(String? value) {
    emailController.text = value ?? '';
  }

  void passwordOnSaved(String? value) {
    passwordController.text = value ?? '';
  }
}
