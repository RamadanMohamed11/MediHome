import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihome/core/helper/show_dialog.dart';
import 'package:medihome/core/widgets/loading_widget.dart';
import 'package:medihome/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:medihome/features/authentication/presentation/widgets/login_container.dart';
import 'package:medihome/features/authentication/presentation/widgets/medi_home_with_icon_widget.dart';
import 'package:medihome/features/authentication/presentation/widgets/top_image.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSignUpSuccess) {
          showMessageDialog(
            context,
            true,
            false,
            "Email created successfully",
            btnOkOnPress: () {},
          );
          BlocProvider.of<AuthenticationCubit>(context).emitInitial();
        }
        if (state is AuthenticationFailure) {
          showMessageDialog(
            context,
            false,
            false,
            state.errorMessage,
            btnOkOnPress: () {},
          );
          BlocProvider.of<AuthenticationCubit>(context).emitInitial();
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial ||
              state is AuthenticationSignUpSuccess) {
            return LoginBody();
          } else if (state is AuthenticationLoading) {
            return LoadingWidget();
          } else {
            return Text("Error");
          }
        },
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
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
        ),
      );
    });
  }
}
