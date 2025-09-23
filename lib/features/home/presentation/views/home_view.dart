import 'package:flutter/material.dart';
import 'package:medihome/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';
import 'package:medihome/generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeViewBody(userModel: userModel),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        onPressed: () {},
        icon: Icon(Icons.add, size: 24),
        label: Text(
          S.of(context).addMedication,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
