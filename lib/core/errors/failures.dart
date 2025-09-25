import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

// Firebase Failure
class AuthFailure extends Failure {
  AuthFailure(super.errorMessage);

  factory AuthFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthFailure("The email address is not valid.");
      case 'user-disabled':
        return AuthFailure("This user account has been disabled.");
      case 'user-not-found':
        return AuthFailure("No user found for this email.");
      case 'invalid-credential':
        return AuthFailure("The email address is not valid or wrong password.");
      case 'email-already-in-use':
        return AuthFailure("This email is already in use.");
      case 'weak-password':
        return AuthFailure("Password is too weak.");
      case 'operation-not-allowed':
        return AuthFailure("This sign-in method is not allowed.");
      default:
        return AuthFailure("${e.message}");
    }
  }

  factory AuthFailure.fromException(Exception e) {
    if (e is FirebaseAuthException) {
      return AuthFailure.fromFirebaseAuthException(e);
    } else {
      return AuthFailure("Unexpected error: $e");
    }
  }
}
