import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> login({required String email, required String password}) async {
    try {
      if (kDebugMode) {
        print('Logging in with email: $email');
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('Login successful');
      }
      return userCredential.user!;
    } catch (e) {
      if (kDebugMode) {
        print('Login failed: $e');
      }
      throw Exception('Login failed');
    }
  }
}
