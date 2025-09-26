import 'package:flutter/material.dart';
import 'package:medihome/core/widgets/medi_home_with_icon_widget.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';
import 'package:medihome/features/home/presentation/views/widgets/medication_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 30),
          MediHomeWithIconWidget(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 5),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: MedicationWidget(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
