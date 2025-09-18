import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showMessageDialog(
  BuildContext context,
  bool isSuccessful,
  bool isSignout,
  String message, {
  void Function()? btnOkOnPress,
}) {
  AwesomeDialog(
    dialogBackgroundColor: Colors.blue,
    context: context,
    animType: AnimType.bottomSlide,
    dialogType: (isSuccessful)
        ? DialogType.success
        : (isSignout)
        ? DialogType.question
        : DialogType.error,
    title: isSuccessful
        ? "Success"
        : (isSignout)
        ? "Signout"
        : "Error",
    titleTextStyle: TextStyle(
      color: isSuccessful ? Colors.greenAccent : Colors.redAccent,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    desc: message,
    descTextStyle: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    btnOkText: "Ok",
    buttonsTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    btnOkOnPress: btnOkOnPress,
  ).show();
}
