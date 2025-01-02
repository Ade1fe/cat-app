import 'package:cat_shop/routes/app_routes.dart';
import 'package:cat_shop/routes/route_names.dart';
import 'package:cat_shop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RouteNames.home,
    );
  }
}
