import 'package:flutter/material.dart';
import 'package:map_exam/view/home/home_screen.dart';
import 'package:map_exam/view/login/login_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => LoginScreen(),
      home: (context) => HomeScreen(),
    };
  }
}
