import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User signed in: ${userCredential}");
      return userCredential;
    } catch (e) {
      print('Error during sign-in: $e');
      rethrow;
    }
  }

  Future<void> signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print("Error on sign out ${e}");
      rethrow;
    }
  }
}
