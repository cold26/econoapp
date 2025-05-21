import 'package:econoapp/common/models/user_model.dart';
import 'package:econoapp/common/services/auth_service.dart';
import 'package:econoapp/common/services/secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements SecureStorage {}

class MockUser extends Mock implements UserModel {}