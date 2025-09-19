import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState(locale: Locale('en')));

  void toEnglish() {
    emit(const LocalizationState(locale: Locale('en')));
  }

  void toArabic() {
    emit(const LocalizationState(locale: Locale('ar')));
  }
}
