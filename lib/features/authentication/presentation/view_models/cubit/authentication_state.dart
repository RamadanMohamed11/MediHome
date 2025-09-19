part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationLoginSuccess extends AuthenticationState {}

final class AuthenticationSignUpSuccess extends AuthenticationState {}

final class AuthenticationSignOutSuccess extends AuthenticationState {}

final class AuthenticationForgetPasswordSuccess extends AuthenticationState {}

final class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;
  AuthenticationFailure(this.errorMessage);
}
