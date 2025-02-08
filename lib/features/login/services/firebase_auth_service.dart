import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> login({required String email, required String password}) async {
    try {
      print('Logging in with email: $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Login successful');
      return userCredential.user!;
    } catch (e) {
      print('Login failed: $e');
      throw Exception('Login failed');
    }
  }
}
