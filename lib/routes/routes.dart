import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growth/views/screens/homeScreen.dart';
import 'package:growth/views/screens/login.dart';
import 'package:growth/views/screens/onboarding.dart';
import 'package:growth/views/screens/register.dart';
import 'package:growth/views/screens/splashScreen.dart';

class RouteNames {
  static const String splashScreen = 'splashScreen';
  static const String onboardingScreen = 'onboardingScreen';
  static const String loginScreen = 'loginScreen';
  static const String registerScreen = 'registerScreen';
  static const String homeScreen = 'homeScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) => const SplashScreen(),
    onboardingScreen: (context) => Onboarding(),
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case onboardingScreen:
        return MaterialPageRoute(builder: (context) => Onboarding());
      case loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      //Default Route is error route
      default:
        return CupertinoPageRoute(builder: (context) => errorView(''));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
