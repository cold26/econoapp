// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:econoapp/common/constants/app_colors.dart';
import 'package:econoapp/common/constants/app_text_styles.dart';
import 'package:econoapp/common/constants/routes.dart';
import 'package:econoapp/common/widgets/multi_text_button.dart';
import 'package:econoapp/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Column(
        children: [
          const SizedBox(height: 48.0),
          Expanded(
            child: Image.asset(
              'assets/images/Group 1.png',
            ),
          ),
          Text(
            'Gaste De Forma',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          Text(
            'Inteligente.',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText36.copyWith(
              color: AppColors.greenOne,
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
              text: 'Comece Agora',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NamedRoute.signUp,
                );
              },
            ),
          ),
          MultiTextButton(
            onPressed: () => Navigator.pushNamed(context, NamedRoute.signIn),
            children: [
              Text(
                'Já é cadastrado? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Entre',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenOne,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
