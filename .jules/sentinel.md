## 2024-05-28 - Removed Sensitive Information Logging in AuthService

**Vulnerability:** The application was logging instances of `FirebaseAuthException` to the console using `print(e)` during both user signup and login processes in `lib/src/services/auth_service.dart`. This could potentially leak internal application state or sensitive information to the logs, which might be accessible to unauthorized parties if logs are not properly secured. Additionally, user input for email and password lacked basic validation and sanitization before being passed to Firebase Authentication methods.

**Learning:** It is crucial to sanitize error messages and ensure that sensitive information is not recorded in application logs. Failing securely means handling exceptions without exposing underlying details that could aid an attacker. Furthermore, basic input validation (like trimming whitespace and checking format) should be implemented as early as possible to prevent malformed data from reaching backend services.

**Prevention:** To prevent similar vulnerabilities:
- Never log raw exception objects or sensitive data (like passwords, keys, or internal error specifics) to the console or log files. Use a structured logging mechanism that sanitizes output.
- Implement input validation and sanitization for all user-provided data before using it in authentication flows or passing it to external services.
- Return generic error messages to the user and log a sanitized error identifier for debugging purposes.
## 2024-03-24 - Missing Input Validation
**Vulnerability:** Lack of client-side input validation on authentication screens (login and signup).
**Learning:** Found that basic UI forms for sensitive operations were not validating input format or strength, which can lead to unnecessary backend calls with invalid data or weak passwords.
**Prevention:** Implement validation logic at the UI boundary before calling authentication services. Ensure minimum password complexity and valid email formats are checked.

## 2024-05-28 - Missing Input Length Limitations
**Vulnerability:** Found lack of input length validation (like `maxLength`) on text fields for user-facing auth screens (`login_screen.dart` and `signup_screen.dart`). Attackers could submit massive payloads leading to app memory exhaustion or excessive backend processing (Denial of Service).
**Learning:** Even with backend sanitization, client-side screens are vulnerable to malicious payload exhaustion if unconstrained.
**Prevention:** Implement reasonable `maxLength` limits on `TextField` components handling user input to explicitly bounds-check the input size before application logic attempts processing.
