import 'package:econoapp/common/models/user_model.dart';
import 'package:econoapp/common/services/auth_service.dart';

class MockAuthService  implements AuthService{
  @override
  Future signIn() {
    // TODO: Implement signIn functionality
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp({
    String? name,
     required String email,
      required String password,
      }) async {
      await Future.delayed(const Duration(seconds: 2));
    try {
      if (password.startsWith('123')) {
        throw Exception("Erro ao logar");
      }
      return UserModel(
        id: email.hashCode,
        name: name,
        email: email,
      );
    } catch (e) {
    if (password.startsWith('123')) {
      throw 'Senha insegura. Tente novamente com uma senha mais forte.';
    }
    }
    throw 'Não foi possivel criar sua conta nesse momento.';
  }
}