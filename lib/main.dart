import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/routes/routes.dart';
import 'package:map_exam/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

// import 'login_screen.dart';
// import 'home_screen.dart';
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
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(), // Provide the LoginViewModel
      child: MaterialApp(
        title: 'myFirst',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.login, // Set initial route to login screen
        routes:
            AppRoutes.routes(), // Use the routes defined in the AppRoutes class
      ),
    );
  }
}
