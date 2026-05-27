## 2024-03-24 - Missing Input Validation
**Vulnerability:** Lack of client-side input validation on authentication screens (login and signup).
**Learning:** Found that basic UI forms for sensitive operations were not validating input format or strength, which can lead to unnecessary backend calls with invalid data or weak passwords.
**Prevention:** Implement validation logic at the UI boundary before calling authentication services. Ensure minimum password complexity and valid email formats are checked.
