import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medihome/core/utils/authentication_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationService authenticationService;
  AuthenticationCubit({required this.authenticationService})
    : super(AuthenticationInitial());

  void emitInitial() => emit(AuthenticationInitial());

  // Simulate a login process
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    emit(AuthenticationLoading());
    authenticationService.signUp(email: email, password: password, name: name);
    emit(AuthenticationSignUpSuccess());
    GoRouter.of(context).pop();
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthenticationLoading());
    authenticationService.signIn(email: email, password: password);
    emit(AuthenticationLoginSuccess());
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
}
