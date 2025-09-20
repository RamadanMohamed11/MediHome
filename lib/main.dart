import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medihome/core/cubits/localization/localization_cubit.dart';
import 'package:medihome/core/helper/get_locale_from_hive.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/core/utils/authentication_service.dart';
import 'package:medihome/core/utils/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/generated/l10n.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await Hive.openBox('locale');

  setupServiceLocator();
  runApp(const MediHome());
}

class MediHome extends StatelessWidget {
  const MediHome({super.key});

  @override
  Widget build(BuildContext context) {
    // create multi bloc provider

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
            authenticationService: AuthenticationService(),
          ),
        ),
        BlocProvider<LocalizationCubit>(
          create: (context) => LocalizationCubit(),
        ),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: getLocaleFromHive(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: AppRouter.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: const Color(0xff080E1C),
            ),
          );
        },
      ),
    );
  }
}
