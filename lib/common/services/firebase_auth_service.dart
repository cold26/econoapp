import 'package:cloud_functions/cloud_functions.dart';
import 'package:econoapp/common/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _functions = FirebaseFunctions.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(
          name: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
          id: _auth.currentUser?.uid,
        );
      } else {
        throw Exception("Usuário não autenticado");
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Erro no login";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      // Chama a função de Cloud Functions para registrar o usuário
      await _functions.httpsCallable('registerUser').call({
        "email": email,
        "password": password,
        "displayName": name,
      });

      // Realiza o login após o cadastro
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Aqui vamos adicionar a verificação para garantir que o usuário foi autenticado
        print("Usuário autenticado: ${_auth.currentUser?.uid}");

        // Tenta obter o token após a autenticação
        final token = await _auth.currentUser?.getIdToken();
        if (token != null) {
          print("TOKEN após login: $token"); // Imprime o token no console
        } else {
          print("Token não gerado.");
        }

        return UserModel(
          name: _auth.currentUser?.displayName,
          email: _auth.currentUser?.email,
          id: _auth.currentUser?.uid,
        );
      } else {
        throw Exception("Usuário não autenticado");
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Erro no cadastro";
    } on FirebaseFunctionsException catch (e) {
      throw e.message ?? "Erro ao chamar a função do Firebase";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> get userToken async {
    try {
      // Tenta obter o token do usuário atual
      final token = await _auth.currentUser?.getIdToken();
      if (token != null) {
        // Imprime o token para depuração
        print("TOKEN do usuário: $token");
        return token;
      } else {
        throw Exception('Usuário não encontrado');
      }
    } catch (e) {
      rethrow;
    }
  }
}
