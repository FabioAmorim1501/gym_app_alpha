1. Add input sanitization and length limits to `login_screen.dart` and `signup_screen.dart`
2. Update `auth_service.dart` to fix duplicate variable declaration `userCredential`, sanitize input earlier, remove printing raw `FirebaseAuthException` to prevent leaking details.
3. Fix duplicate `dispose` implementations in both auth screens.
4. Clean up `user_model.dart` import issue in `worker_model.dart`.
5. Update `payment_service_test.dart` warning by returning a Mock value or null explicitly if needed.
6. Commit the changes, adding critical logging to `.jules/sentinel.md`.
