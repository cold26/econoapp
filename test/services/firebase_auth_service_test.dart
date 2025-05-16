import 'package:econoapp/common/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_classes.dart';

void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
      user = UserModel(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      id: '123456789',
    );
  });

  group(
    'Teste de AuthService',
     (){
 test('Teste de SignUp success', () async {
  

    when(() => mockFirebaseAuthService.signUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
    ),
    ).thenAnswer(
      (_) async => user);

    final result = await mockFirebaseAuthService.signUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
    );

    expect(result, user);
  });

  test('Teste de SignUp Fail', () async {
  

    when(() => mockFirebaseAuthService.signUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
    ),
    ).thenThrow(
      Exception(),
      );

    expect(
    () => mockFirebaseAuthService.signUp(
    name: 'Usuario1',
    email: 'usuario1@gmail.com',
    password: 'teste123456',
    ),
    throwsA(isInstanceOf<Exception>()));
  });

     });

 

}

