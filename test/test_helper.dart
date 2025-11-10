import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

// This is the new way to mock Firebase initialization.
// We create a mock implementation of the FirebasePlatform.
class MockFirebasePlatform extends FirebasePlatform {
  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return MockFirebaseApp();
  }
}

// A mock implementation of FirebaseAppPlatform.
class MockFirebaseApp extends FirebaseAppPlatform {
  MockFirebaseApp() : super(defaultFirebaseAppName, const FirebaseOptions(
    apiKey: 'test-api-key',
    appId: 'test-app-id',
    messagingSenderId: 'test-sender-id',
    projectId: 'test-project-id',
  ));
}

// The setupTest function now uses the mock platform.
Future<void> setupTest() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Set the mock platform before initializing the app.
  FirebasePlatform.instance = MockFirebasePlatform();
  await Firebase.initializeApp();
}
