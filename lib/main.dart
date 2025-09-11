import 'package:flutter/material.dart';
import 'package:medihome/features/authentication/presentation/views/login_view.dart';

void main() {
  runApp(const MediHome());
}

class MediHome extends StatelessWidget {
  const MediHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xff080E1C),
      ),
    );
  }
}
