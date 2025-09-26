import 'package:flutter/material.dart';
import 'package:medihome/generated/l10n.dart';
import 'package:medihome/core/helper/text_form_filed_validations.dart';

class MedicationNameTextFormField extends StatelessWidget {
  const MedicationNameTextFormField({
    super.key,
    required this.nameController,
    required this.onSavedMethod,
  });
  final TextEditingController nameController;
  final Function(String?)? onSavedMethod;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: TextFormFiledValidations.nameValidation,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: S.of(context).medicineName,
        hintStyle: TextStyle(color: Colors.white60),
        prefixIcon: Icon(Icons.medication_outlined, color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      controller: nameController,
      onSaved: onSavedMethod,
    );
  }
}
