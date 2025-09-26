import 'package:flutter/material.dart';
import 'package:medihome/core/helper/text_form_filed_validations.dart';

class DoseNumbersTextFormField extends StatelessWidget {
  const DoseNumbersTextFormField({
    super.key,
    required this.currentStockController,
    required this.onSavedMethod,
    required this.onIncrement,
    required this.onDecrement,
    required this.hintText,
  });
  final TextEditingController currentStockController;
  final Function(String?)? onSavedMethod;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: '0',
      keyboardType: TextInputType.number,
      validator: TextFormFiledValidations.numberValidation,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hint: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(hintText, style: TextStyle(color: Colors.white60)),
        ),
        prefixIcon: Icon(
          Icons.store_mall_directory_outlined,
          color: Colors.white70,
        ),
        suffixIcon: SizedBox(
          height: 60,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white70,
                  ),
                  onPressed: onIncrement,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white70,
                  ),
                  onPressed: onDecrement,
                ),
              ],
            ),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      controller: currentStockController,
      onSaved: onSavedMethod,
    );
  }
}
