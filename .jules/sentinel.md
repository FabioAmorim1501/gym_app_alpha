## 2024-05-24 - [Information Disclosure in Error Logging]
**Vulnerability:** Raw `FirebaseAuthException` objects were being logged directly using `print(e)`. This can leak sensitive data (e.g., user emails) or implementation details from the stack trace to anyone with access to the application logs.
**Learning:** Generic error logging is required to prevent sensitive information disclosure.
**Prevention:** Always use generic error messages when logging authentication errors or errors that may contain user-provided data or internal system details.
