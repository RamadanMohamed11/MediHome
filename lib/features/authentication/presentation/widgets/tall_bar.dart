import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TallBar extends StatelessWidget {
  const TallBar({super.key, required this.isRight});
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue,
      highlightColor: Colors.white,
      period: Duration(seconds: 5),
      child: Container(
        height: 2,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
