import 'package:flutter/material.dart';
import 'package:medihome/core/helper/text_form_filed_validations.dart';
import 'package:medihome/generated/l10n.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.nameController,
    required this.onSavedMethod,
  });
  final TextEditingController nameController;
  final Function(String?)? onSavedMethod;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSavedMethod,
      controller: nameController,
      validator: TextFormFiledValidations.nameValidation,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: S.of(context).enterYourName,
        hintStyle: TextStyle(color: Colors.white60),
        prefixIcon: Icon(Icons.person_outline, color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
