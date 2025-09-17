import 'package:flutter/material.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/core/utils/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  runApp(const MediHome());
}

class MediHome extends StatelessWidget {
  const MediHome({super.key});

  @override
  Widget build(BuildContext context) {
    // create multi bloc provider

    return MaterialApp.router(
      routerConfig: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xff080E1C),
      ),
    );
  }
}
