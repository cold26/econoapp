import 'dart:developer'; // Remova a importação de log de dart:math
import 'package:econoapp/common/constants/routes.dart';
import 'package:econoapp/common/constants/widgets/multi_text_button.dart';
import 'package:econoapp/common/constants/widgets/primary_button.dart';
import 'package:econoapp/features/sign_up/sign_up_page.dart';
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
            Expanded(flex: 2, child: Image.asset('assets/images/Group 1.png')),
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
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32.0,
                top: 16.0,
                bottom: 4.0,
              ),
              child: PrimaryButton(
                text: 'Comece agora',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    NamedRoutes.signUp,
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            MultiTextButton(
              onPressed: () => Navigator.pushNamed(context, NamedRoutes.signIn),
              children: [
                Text(
                  'Já é cadastrado?',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  ' Log In ',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.greenTwo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
