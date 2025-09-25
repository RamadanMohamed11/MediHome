import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/authentication_service.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';
import 'package:medihome/features/authentication/data/repos/auth_repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthRepo authRepo;
  AuthenticationService authenticationService;
  AuthenticationCubit({
    required this.authRepo,
    required this.authenticationService,
  }) : super(AuthenticationInitial());

  void emitInitial() => emit(AuthenticationInitial());

  // Simulate a login process
  // Future<void> signUp({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     emit(AuthenticationLoading());
  //     await authenticationService.signUp(
  //       email: email,
  //       password: password,
  //       name: name,
  //     );
  //     emit(AuthenticationSignUpSuccess());
  //   } catch (e) {
  //     emit(AuthenticationFailure(e.toString()));
  //   }
  // }
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    emit(AuthenticationLoading());
    var result = await authRepo.signUp(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) => emit(AuthenticationFailure(failure.errorMessage)),
      (userResult) {
        emit(AuthenticationSignUpSuccess());
      },
    );
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthenticationLoading());
    var result = await authRepo.signIn(email: email, password: password);

    return result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.errorMessage));
        return null;
      },
      (userResult) {
        emit(AuthenticationLoginSuccess());
        return userResult;
      },
    );
  }

  Future<void> signOut() async {
    emit(AuthenticationLoading());
    authenticationService.signOut();
    emit(AuthenticationSignOutSuccess());
  }

  Future<void> forgetPassword({
    required String email,
    required BuildContext context,
  }) async {
    emit(AuthenticationLoading());
    authenticationService.forgetPassword(email: email);
    emit(AuthenticationForgetPasswordSuccess());
    GoRouter.of(context).pop();
  }

  Future<UserModel?> signInWithGoogle(BuildContext context) async {
    emit(AuthenticationLoading());
    UserModel? userModel = await authenticationService.signInWithGoogle(
      context,
    );
    emit(AuthenticationLoginSuccess());
    return userModel;
  }
}
