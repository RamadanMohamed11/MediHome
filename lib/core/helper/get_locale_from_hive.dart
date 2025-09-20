import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Locale getLocaleFromHive() {
  final box = Hive.box('locale');
  final locale = box.get("locale", defaultValue: "en");
  return Locale(locale);
}
