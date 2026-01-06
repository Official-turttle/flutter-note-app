import 'package:flutter/material.dart';
import 'package:map_exam/data/repository/auth.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool isLoading = false;
  String? errorMessage;

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.signIn(email, password);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      debugPrint('Sign-in error: $e');
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
