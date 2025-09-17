import 'package:flutter/material.dart';
import 'package:medihome/core/helper/text_form_filed_validations.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: true,
      validator: TextFormFiledValidations.passwordValidation,
      decoration: InputDecoration(
        hintText: "Enter your password",
        hintStyle: TextStyle(color: Colors.white60),
        prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
        suffixIcon: Icon(Icons.remove_red_eye, color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
