import 'package:econoapp/common/constants/routes.dart';
import 'package:econoapp/features/onboarding/onboarding.dart';
import 'package:econoapp/features/sign_in/sign_in_page.dart';
import 'package:econoapp/features/sign_up/sign_up_page.dart';
import 'package:econoapp/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // theme: DefaultTheme.lightTheme,
      initialRoute: NamedRoutes.splash,
      routes: {
        NamedRoutes.initial: (context) => OnboardingPage(),
        NamedRoutes.splash : (context) => const SplashPage(),
        NamedRoutes.signUp : (context) => const SignUpPage(),
        NamedRoutes.signIn : (context) => const SignInPage(),
      },
    );
  }
}
