import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState(locale: Locale('en')));

  void toEnglish() {
    // save them to box
    final box = Hive.box("locale");
    box.put("locale", "en");
    emit(const LocalizationState(locale: Locale('en')));
  }

  void toArabic() {
    final box = Hive.box("locale");
    box.put("locale", "ar");
    emit(const LocalizationState(locale: Locale('ar')));
  }
}
