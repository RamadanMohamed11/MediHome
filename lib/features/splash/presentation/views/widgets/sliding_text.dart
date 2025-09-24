import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.textSlidingAnimation,
    required this.text,
  });

  final Animation<Offset> textSlidingAnimation;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: textSlidingAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: textSlidingAnimation,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
