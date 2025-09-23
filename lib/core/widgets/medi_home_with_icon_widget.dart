import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediHomeWithIconWidget extends StatelessWidget {
  const MediHomeWithIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.blue,
          highlightColor: Colors.grey,
          period: Duration(seconds: 5),
          child: Icon(
            Icons.medication_liquid_rounded,
            size: 35,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 8),
        Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.blue,
          period: Duration(seconds: 5),
          child: Text(
            "MediHome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
