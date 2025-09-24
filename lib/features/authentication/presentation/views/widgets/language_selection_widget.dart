import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihome/core/cubits/localization/localization_cubit.dart';
import 'package:medihome/core/helper/get_locale_from_hive.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context).toEnglish();
              },
              child: Text(
                'English',
                style: TextStyle(
                  color: getLocaleFromHive().languageCode == 'en'
                      ? Colors.blue
                      : Colors.grey,
                  fontSize: 20,
                  fontWeight: getLocaleFromHive().languageCode == 'en'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context).toArabic();
              },
              child: Text(
                'العربية',
                style: TextStyle(
                  color: getLocaleFromHive().languageCode == 'ar'
                      ? Colors.blue
                      : Colors.grey,
                  fontSize: 20,
                  fontWeight: getLocaleFromHive().languageCode == 'ar'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
