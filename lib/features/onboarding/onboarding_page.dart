import 'dart:developer';  // Remova a importação de log de dart:math
import 'package:econoapp/common/constants/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:econoapp/common/constants/app_colors.dart';
import 'package:econoapp/common/constants/app_text_styles.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.iceWhite,
      body: Align(
        child: Column(
          children: [
            const SizedBox(height: 48.0),
            Expanded(
              flex: 2,
              child: Image.asset('assets/images/Group 1.png'),
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                 vertical: 16.0,
                 ),
              child: PrimaryButton(
                text: 'Comece agora',
                onPressed: () {},
                ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Já é cadastrado? Log in',
              style: AppTextStyles.smallText.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

