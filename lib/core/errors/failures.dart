import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

// Firebase Failure
class FirebaseFailure extends Failure {
  FirebaseFailure(super.errorMessage);

  factory FirebaseFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return FirebaseFailure('No user found for that email.');
      case 'wrong-password':
        return FirebaseFailure('Wrong password provided for that user.');
      case 'email-already-in-use':
        return FirebaseFailure('The account already exists for that email.');
      case 'weak-password':
        return FirebaseFailure('The password provided is too weak.');
      case 'invalid-email':
        return FirebaseFailure('The email address is not valid.');
      default:
        return FirebaseFailure(e.code);
    }
  }
}
