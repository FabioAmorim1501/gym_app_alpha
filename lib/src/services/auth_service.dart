import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    // SECURITY: Input validation to prevent malformed requests and weak passwords
    if (email.isEmpty || !email.contains('@')) {
      print('Security Warning: Invalid email format during signup.');
      return null;
    }
    if (password.length < 8) {
      print('Security Warning: Weak password attempt during signup.');
      return null;
    }

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (_) {
      // SECURITY: Avoid leaking stack traces or internal Firebase error details
      print('Security Error: Authentication failed.');
      return null;
    } catch (_) {
      print('Security Error: Authentication failed.');
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    // SECURITY: Basic input validation
    if (email.isEmpty || password.isEmpty) {
      print('Security Warning: Empty credentials during login.');
      return null;
    }

    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (_) {
      // SECURITY: Avoid leaking stack traces or internal Firebase error details
      print('Security Error: Authentication failed.');
      return null;
    } catch (_) {
      print('Security Error: Authentication failed.');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
