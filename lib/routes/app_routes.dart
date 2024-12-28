import 'package:cat_shop/auth/sign_in_screen.dart';
import 'package:cat_shop/auth/sign_up_screen.dart';
import 'package:cat_shop/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:cat_shop/widgets/bottom_navigation.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteNames.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case RouteNames.dashBoard:
        final fullName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BottomNavigationApp(fullName: fullName),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
