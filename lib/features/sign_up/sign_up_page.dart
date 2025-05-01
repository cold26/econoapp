import 'dart:developer';

import 'package:econoapp/common/constants/app_colors.dart';
import 'package:econoapp/common/constants/app_text_styles.dart';
import 'package:econoapp/common/constants/widgets/custom_text_form_field.dart';
import 'package:econoapp/common/constants/widgets/multi_text_button.dart';
import 'package:econoapp/common/constants/widgets/password_form_field.dart';
import 'package:econoapp/common/constants/widgets/primary_button.dart';
import 'package:econoapp/common/utils/validator.dart';
import 'package:econoapp/features/sign_up/sign_up_controller.dart';
import 'package:econoapp/features/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controller = SignUpController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.initState();
  }

  @override
void initState() {
  super.initState();
  _controller.addListener(() {
    log(_controller.state.toString());

    if (_controller.state is SignUpLoadingState) {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
    }

    if (_controller.state is SignUpSucessState) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Nova tela"),
            ),
          ),
        ),
      );
    }

    if (_controller.state is SignUpErrorState) {
      showBottomSheet(
        context: context,
        builder: (context) => const SizedBox(
          height: 150,
          child: Text("Erro ao Logar.Tente novamente"),
        ),
      );
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
            crossAxisAlignment:
                CrossAxisAlignment
                    .center, // Centraliza o conteúdo horizontalmente
            children: [
              Text(
                'Gaste de forma',
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenTwo,
                ),
              ),
              Text(
                'Inteligente.',
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenTwo,
                ),
              ),
            ],
          ),
          Image.asset('assets/images/sign_up_image.png'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Digite seu nome',
                  labelText: 'Seu nome',
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  hintText: 'Digite seu email',
                  labelText: 'Seu email',
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Escolha uma senha",
                  hintText: "********",
                  helperText: 'A senha deve ter no mínimo 8 caracteres',
                ),
                PasswordFormField(
                  controller: TextEditingController(),
                  labelText: "Confirme sua senha",
                  hintText: "********",
                  validator:
                      (value) => Validator.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                ),
              ],
            ),
          ),
          const TextField(),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Entrar',
              onPressed: () {
                final valid =
                    _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.doSignUp();
                } else {
                  log('erro ao logar');
                }
              },
            ),
          ),
          const SizedBox(height: 16.0),
          MultiTextButton(
            onPressed: () => log('tap'),
            children: [
              Text(
                'Já é cadastrado?',
                style: AppTextStyles.smallText.copyWith(color: AppColors.grey),
              ),
              Text(
                ' Log In ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenTwo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
