import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/features/authentication/presentation/widgets/custom_button.dart';
import 'package:medihome/features/authentication/presentation/widgets/email_text_form_field.dart';
import 'package:medihome/features/authentication/presentation/widgets/medi_home_with_icon_widget.dart';
import 'package:medihome/features/authentication/presentation/widgets/top_image.dart';
import 'package:medihome/generated/l10n.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Column(
            children: [
              TopImage(),
              SizedBox(height: 24),
              Spacer(),
              MediHomeWithIconWidget(),
              SizedBox(height: 6),
              Opacity(opacity: 0.9, child: ForgetPasswordContainer()),
              Spacer(flex: 2),
            ],
          ),
        ),
      ],
    );
  }
}

class ForgetPasswordContainer extends StatefulWidget {
  const ForgetPasswordContainer({super.key});

  @override
  State<ForgetPasswordContainer> createState() =>
      _ForgetPasswordContainerState();
}

class _ForgetPasswordContainerState extends State<ForgetPasswordContainer> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).enterYourEmailToResetYourPassword,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 24),
            EmailTextFormField(
              emailController: emailController,
              onSavedMethod: emailOnSaved,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: S.of(context).send,
                    onPressed: sendOnPressed,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendOnPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      BlocProvider.of<AuthenticationCubit>(
        context,
      ).forgetPassword(email: emailController.text, context: context);
    }
  }

  void emailOnSaved(String? value) {
    emailController.text = value ?? '';
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
