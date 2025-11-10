import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart'
    as platform;
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_app_alpha/src/services/auth_service.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
}

void main() {
  setupFirebaseAuthMocks();

  group('AuthService', () {
    late MockFirebaseAuth auth;
    late AuthService authService;

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    setUp(() {
      auth = MockFirebaseAuth();
      authService = AuthService(auth: auth);
    });

    test('signUp creates a user', () async {
      final user = await authService.signUp('test@example.com', 'password');
      expect(user, isNotNull);
    });

    test('login returns a user', () async {
      await authService.signUp('test@example.com', 'password');
      final user = await authService.login('test@example.com', 'password');
      expect(user, isNotNull);
    });

    test('signOut signs out the user', () async {
      await authService.signOut();
      expect(auth.currentUser, isNull);
    });
  });
}
