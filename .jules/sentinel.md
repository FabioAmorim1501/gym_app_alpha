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

## 2024-05-28 - Removed Generic Rethrowing in PaymentService
**Vulnerability:** The `PaymentService` was using `rethrow` within its try-catch block for processing payments (`makePayment` method). This could inadvertently leak sensitive stack traces and internal application or third-party SDK errors directly to the calling context or unhandled exception loggers.
**Learning:** Raw stack traces from critical dependencies (like Stripe or Firestore) can expose internal paths or logic which an attacker could use. It's safer to catch such errors and wrap them in a generic application-level exception.
**Prevention:** Use a standard try-catch block without `rethrow` for third-party SDKs or backend services unless the exception is caught and sanitized at a higher level. Instead, throw a generic `Exception('Payment processing failed. Please try again later.')` to safely manage the user experience without exposing implementation details.

## 2024-06-06 - Unhandled FormatException and Unbounded Input Length in Forms
**Vulnerability:** The application was using `int.parse()` on user inputs for 'Sets' and 'Reps' without catching `FormatException` or validating the input length beforehand. Empty, non-numeric, or excessively long strings would crash the app entirely due to the unhandled exception, presenting a client-side Denial of Service (DoS) risk. Furthermore, unbounded text fields allowed malicious input which could excessively allocate memory.
**Learning:** Parsing user input directly with `int.parse()` or similar strict typing functions without validation or try/catch blocks exposes apps to easy client-side crashes, especially with user-generated content.
**Prevention:** Always use safe parsing methods like `int.tryParse()` and handle `null` returns gracefully with user feedback (like a SnackBar). Additionally, enforce `maxLength` on TextFields to prevent large strings from consuming excessive memory and potentially causing a Denial of Service (DoS).
