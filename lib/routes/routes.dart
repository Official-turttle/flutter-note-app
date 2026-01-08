import 'package:flutter/material.dart';
import 'package:map_exam/view/home/edit_screen.dart';
import 'package:map_exam/view/home/home_screen.dart';
import 'package:map_exam/view/login/login_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String edit = '/edit';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case edit:
        final args = settings.arguments as Map<String, dynamic>;
        final mode = args['mode']; // Get mode (view, edit, add)
        final note = args['note']; // Get the note (if any)

        // Return the EditScreen with the appropriate arguments
        return MaterialPageRoute(
          builder: (_) => EditScreen(note: note, mode: mode),
        );
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  static Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => LoginScreen(),
      home: (context) => HomeScreen(),
    };
  }
}
