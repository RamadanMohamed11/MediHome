import 'package:flutter/material.dart';
import 'package:medihome/core/helper/text_form_filed_validations.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
    required this.onSavedMehod,
  });
  final TextEditingController emailController;
  final Function(String?)? onSavedMehod;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSavedMehod,
      controller: emailController,
      validator: TextFormFiledValidations.emailValidation,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Enter your email",
        hintStyle: TextStyle(color: Colors.white60),
        prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
