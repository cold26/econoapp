import 'dart:developer';

import 'package:econoapp/common/constants/app_colors.dart';
import 'package:econoapp/common/constants/app_text_styles.dart';
import 'package:econoapp/common/constants/routes.dart';
import 'package:econoapp/common/constants/widgets/custom_bottom_sheet.dart';
import 'package:econoapp/common/constants/widgets/custom_circular_progress_indicator.dart';
import 'package:econoapp/common/constants/widgets/custom_text_form_field.dart';
import 'package:econoapp/common/constants/widgets/multi_text_button.dart';
import 'package:econoapp/common/constants/widgets/password_form_field.dart';
import 'package:econoapp/common/constants/widgets/primary_button.dart';
import 'package:econoapp/common/utils/validator.dart';
import 'package:econoapp/features/sign_in/sign_in_controller.dart';
import 'package:econoapp/features/sign_in/sign_in_state.dart';
import 'package:econoapp/locator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _controller = locator.get<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
      if (_controller.state is SignInStateLoading) {
        showDialog(
          context: context,
          builder: (context) => CustomCircularProgressIndicator(),
        );
      }

      if (_controller.state is SignInStateSuccess) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => const Scaffold(
                  body: Center(
                    child: Text("Nova tela"),
                    ),
                    ),
          ),
        );
      }

      if (_controller.state is SignInStateError) {
        final error = _controller.state as SignInStateError;
        Navigator.pop(context);
        customModalBottomSheet(
          context,
          content: error.message,
          buttonText: "Tentar novamente",
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
                'Bem vindo de volta',
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenTwo,
                ),
              ),
            ],
          ),
          Image.asset('assets/images/sign_in_image.png'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Digite seu email',
                  labelText: 'Seu email',
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Digite sua senha",
                  hintText: "********",
                  helperText: 'A senha deve ter no mínimo 8 caracteres',
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
                  _controller.signIn(
                  email: _emailController.text,              
                  password: _passwordController.text,  
                  );
                } else {
                  log('erro ao logar');
                }
              },
            ),
          ),
          const SizedBox(height: 16.0),
          MultiTextButton(
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoutes.signUp),
            children: [
              Text(
                'Ainda não é cadastrado??',
                style: AppTextStyles.smallText.copyWith(color: AppColors.grey),
              ),
              Text(
                ' Cadastre-se ',
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


