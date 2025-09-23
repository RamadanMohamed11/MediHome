import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihome/core/widgets/loading_widget.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/core/widgets/medi_home_with_icon_widget.dart';
import 'package:medihome/features/authentication/presentation/widgets/register_container.dart';
import 'package:medihome/features/authentication/presentation/widgets/top_image.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        print(state);
        if (state is AuthenticationInitial) {
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
                      child: Opacity(opacity: 0.9, child: RegisterContainer()),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
