import 'package:econoapp/common/services/auth_service.dart';
import 'package:econoapp/common/services/firebase_auth_service.dart';
import 'package:econoapp/common/services/secure_storage.dart';
import 'package:econoapp/features/home/home_controller.dart';
import 'package:econoapp/features/sign_in/sign_in_controller.dart';
import 'package:econoapp/features/sign_up/sign_up_controller.dart';
import 'package:econoapp/features/splash/splash_controller.dart';
import 'package:econoapp/repositories/transaction_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  locator.registerFactory<SplashController>(
    () => SplashController(const SecureStorage()));

  locator.registerFactory<SignInController>(
    () => SignInController(locator.get<AuthService>()));

  locator.registerFactory<SignUpController>(
    () => SignUpController(locator.get<AuthService>(), const SecureStorage()));


  locator.registerFactory<TransactionRepository>(
    () => TransactionRepositoryImpl());

  locator.registerLazySingleton<HomeController>(
    () => HomeController(locator.get<TransactionRepository>()));

}