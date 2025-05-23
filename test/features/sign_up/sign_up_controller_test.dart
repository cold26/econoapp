import 'package:econoapp/common/models/user_model.dart';
import 'package:econoapp/features/sign_up/sign_up_controller.dart';
import 'package:econoapp/features/sign_up/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mock/mock_classes.dart';



void main() {
  late SignUpController signUpController ;
  late MockSecureStorage mockSecureStorage;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorage = MockSecureStorage();

    signUpController = SignUpController(
      mockFirebaseAuthService,
       mockSecureStorage);
    user = UserModel(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      id: '123456789',
    );
  });

test('Testes sign Up Controller Success State', () async {
  expect(signUpController.state, isInstanceOf<SignUpInitialState>());

  when(() => mockSecureStorage.write(
    key: "CURRENT_USER",
    value: user.toJson(),
  )).thenAnswer((_) async {
    return null;
  });

  when(() => mockFirebaseAuthService.signUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
    ),
    ).thenAnswer(
      (_) async => user);

  await signUpController.doSignUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
  );
  expect(signUpController.state, isInstanceOf<SignUpSuccessState>());
});

test('Testes sign Up Controller Error State', () async {
  expect(signUpController.state, isInstanceOf<SignUpInitialState>());

  when(() => mockSecureStorage.write(
    key: "CURRENT_USER",
    value: user.toJson(),
  )).thenAnswer((_) async {
    return null;
  });

  when(() => mockFirebaseAuthService.signUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
    ),
    ).thenThrow(
      Exception(),
      );

  await signUpController.doSignUp(
      name: 'Usuario1',
      email: 'usuario1@gmail.com',
      password: 'teste123456',
  );
  expect(signUpController.state, isInstanceOf<SignUpErrorState>());
});

}

