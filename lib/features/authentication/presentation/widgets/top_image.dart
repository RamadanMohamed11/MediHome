import 'package:flutter/material.dart';
import 'package:medihome/core/utils/assets_data.dart';

class TopImage extends StatelessWidget {
  const TopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        image: DecorationImage(
          image: AssetImage(AssetsData.loginBackground),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
