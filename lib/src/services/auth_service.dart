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
      // ⚡ Bolt: Removed duplicate API call to createUserWithEmailAndPassword.
      // Impact: Reduces API requests by 50% during sign-up, saving network latency and resources.
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
      // ⚡ Bolt: Removed duplicate API call to signInWithEmailAndPassword.
      // Impact: Reduces API requests by 50% during login, saving network latency and resources.
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
