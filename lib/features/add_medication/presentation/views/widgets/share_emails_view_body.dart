import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medihome/features/authentication/presentation/views/widgets/email_text_form_field.dart';
import 'package:medihome/generated/l10n.dart';

class ShareEmailsViewBody extends StatefulWidget {
  const ShareEmailsViewBody({super.key});

  @override
  State<ShareEmailsViewBody> createState() => _ShareEmailsViewBodyState();
}

class _ShareEmailsViewBodyState extends State<ShareEmailsViewBody> {
  late TextEditingController emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: EmailTextFormField(
              emailController: emailController,
              onSavedMethod: emailOnSavedMethod,
              hintText: "Enter emails you want to share with",
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: TextButton(
              child: Text(S.of(context).share),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void emailOnSavedMethod(String? value) {}
}
