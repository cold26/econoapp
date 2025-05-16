import 'package:econoapp/common/services/auth_service.dart';
import 'package:econoapp/common/services/secure_storage.dart';
import 'package:econoapp/features/sign_up/sign_up_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements SecureStorage {}
