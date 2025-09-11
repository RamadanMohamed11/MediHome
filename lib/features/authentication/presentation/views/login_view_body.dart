import 'package:flutter/material.dart';
import 'package:medihome/features/authentication/presentation/widgets/login_container.dart';
import 'package:medihome/features/authentication/presentation/widgets/medi_home_with_icon_widget.dart';
import 'package:medihome/features/authentication/presentation/widgets/top_image.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Column(
            children: [
              TopImage(),
              SizedBox(height: 24),
              MediHomeWithIconWidget(),
              Expanded(
                flex: 3,
                child: Opacity(opacity: 0.9, child: LoginContainer()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
