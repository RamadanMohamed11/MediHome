import 'package:flutter/material.dart';

class MediHomeWithIconWidget extends StatelessWidget {
  const MediHomeWithIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.medication_liquid_rounded, size: 35, color: Colors.blue),
        SizedBox(width: 8),
        Text(
          "MediHome",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
