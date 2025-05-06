import 'package:econoapp/common/themes/default_theme.dart';
import 'package:econoapp/features/sign_up/sign_up_page.dart';
import 'package:econoapp/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: defaultTheme,
      home: SplashPage());
  }
}
