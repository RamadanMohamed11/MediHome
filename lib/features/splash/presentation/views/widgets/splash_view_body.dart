import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/app_router.dart';
import 'package:medihome/features/splash/presentation/views/widgets/sliding_image.dart';
import 'package:medihome/features/splash/presentation/views/widgets/sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _firstHalfTextSlidingAnimation;
  late Animation<Offset> _secondHalfTextSlidingAnimation;
  late Animation<Offset> _imageSlidingAnimation;
  @override
  void initState() {
    super.initState();

    initSlidingAnimation();

    navigatorToHome();
  }

  void initSlidingAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _firstHalfTextSlidingAnimation =
        Tween<Offset>(begin: const Offset(-5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _secondHalfTextSlidingAnimation =
        Tween<Offset>(begin: const Offset(5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _imageSlidingAnimation =
        Tween<Offset>(begin: const Offset(0, -5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _animationController.forward();
  }

  void navigatorToHome() {
    Future.delayed(Duration(seconds: 3), () {
      GoRouter.of(context).pushReplacement(AppRouter.kLogin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlidingImage(imageSlidingAnimation: _imageSlidingAnimation),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlidingText(
              textSlidingAnimation: _firstHalfTextSlidingAnimation,
              text: "Medi",
            ),
            SlidingText(
              textSlidingAnimation: _secondHalfTextSlidingAnimation,
              text: "Home",
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
