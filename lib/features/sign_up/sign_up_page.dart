import 'dart:developer';

import 'package:econoapp/common/constants/app_colors.dart';
import 'package:econoapp/common/constants/app_text_styles.dart';
import 'package:econoapp/common/constants/widgets/custom_text_form_field.dart';
import 'package:econoapp/common/constants/widgets/multi_text_button.dart';
import 'package:econoapp/common/constants/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                  color: AppColors.greenlightTwo,
                ),
              ),
              Text(
                'Inteligente.',
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
            ],
          ),
          Image.asset('assets/images/sign_up_image.png'),
          Form(
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Digite seu nome',
                  labelText: 'Seu nome',
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
                log('tap');
              },
            ),
          ),
          const SizedBox(height: 16.0),
          MultiTextButton(
            onPressed: () {
              log('tap');
            },
            children: [
              Text(
                'Já é cadastrado?',
                style: AppTextStyles.smallText.copyWith(color: AppColors.grey),
              ),
              Text(
                ' Log In ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


