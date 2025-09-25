import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medihome/core/errors/failures.dart';
import 'package:medihome/core/utils/authentication_service.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';
import 'package:medihome/features/authentication/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthenticationService authenticationService;

  AuthRepoImpl({required this.authenticationService});

  @override
  Future<Either<Failure, int>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await authenticationService.signUp(
        email: email,
        password: password,
        name: name,
      );
      return Right(1);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(AuthFailure.fromFirebaseAuthException(e));
      }
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserModel? userModel = await authenticationService.signIn(
        email: email,
        password: password,
      );
      return Right(userModel);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(AuthFailure.fromFirebaseAuthException(e));
      }
      return Left(AuthFailure(e.toString()));
    }
  }
}
