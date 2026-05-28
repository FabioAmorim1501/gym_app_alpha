import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    // 🛡️ Sentinel: Added basic input validation and sanitized input
    if (email.trim().isEmpty || !email.contains('@') || password.length < 6) {
      return null;
    }
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // 🛡️ Sentinel: Removed print(e) to prevent leaking error details to logs
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    // 🛡️ Sentinel: Added basic input validation and sanitized input
    if (email.trim().isEmpty || password.isEmpty) {
      return null;
    }
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // 🛡️ Sentinel: Removed print(e) to prevent leaking error details to logs
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
