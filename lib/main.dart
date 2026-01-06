import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'login_screen.dart';
import 'home_screen.dart';
// import 'edit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(); // Initialize Firebase
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myFirst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginScreen(),
      // home: const HomeScreen(),
      // home: const EditScreen(),
    );
  }
}
