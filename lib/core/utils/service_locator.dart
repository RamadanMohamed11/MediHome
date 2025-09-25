import 'package:get_it/get_it.dart';
import 'package:medihome/core/utils/authentication_service.dart';
import 'package:medihome/features/authentication/data/repos/auth_repo.dart';
import 'package:medihome/features/authentication/data/repos/auth_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AuthenticationService>(AuthenticationService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authenticationService: getIt.get<AuthenticationService>()),
  );
}
