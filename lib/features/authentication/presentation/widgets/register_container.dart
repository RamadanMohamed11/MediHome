import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/features/authentication/presentation/widgets/custom_button.dart';
import 'package:medihome/features/authentication/presentation/widgets/email_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/widgets/name_text_field.dart';
import 'package:medihome/features/authentication/presentation/widgets/password_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/widgets/tall_bar.dart';
import 'package:shimmer/shimmer.dart';

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
    void registerOnPressed() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        BlocProvider.of<AuthenticationCubit>(context).signUp(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
          context: context,
        );
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
            Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.blue,
              period: Duration(seconds: 5),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Enter your name, email and password to register",
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
                    buttonText: "Register",
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
                Text("OR", style: TextStyle(color: Colors.white, fontSize: 20)),
                Expanded(child: TallBar(isRight: false)),
              ],
            ),
            SizedBox(height: 24),

            /* Gmail Login */
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: "Register with Gmail",
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
                    "Already have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      // push to the register screen using go_router

                      GoRouter.of(context).pop();
                    },
                    child: Text(
                      "Login",
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
