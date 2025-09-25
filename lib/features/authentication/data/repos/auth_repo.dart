import 'package:dartz/dartz.dart';
import 'package:medihome/core/errors/failures.dart';
import 'package:medihome/features/authentication/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, int>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserModel?>> signIn({
    required String email,
    required String password,
  });
}
