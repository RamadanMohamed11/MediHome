import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:medihome/generated/l10n.dart';

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
        ? S.of(context).success
        : (isSignout)
        ? S.of(context).signout
        : S.of(context).error,
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
    btnOkText: S.of(context).ok,
    buttonsTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    btnOkOnPress: btnOkOnPress,
  ).show();
}
