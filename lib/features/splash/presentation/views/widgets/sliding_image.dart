import 'package:flutter/material.dart';
import 'package:medihome/core/utils/assets_data.dart';

class SlidingImage extends StatelessWidget {
  const SlidingImage({super.key, required this.imageSlidingAnimation});

  final Animation<Offset> imageSlidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: imageSlidingAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: imageSlidingAnimation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(AssetsData.logo, fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }
}
