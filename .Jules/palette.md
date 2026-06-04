## 2024-03-24 - Async Form Feedback and Input Types in Auth Screens
**Learning:** During testing of the gym app's authentication screens, it became apparent that submitting login/signup forms without a loading indicator could lead to duplicate submissions and confused users. Furthermore, without proper `keyboardType` (`TextInputType.emailAddress`) and `textInputAction` (`TextInputAction.next`/`done`) configured, the mobile keyboard experience felt disjointed.
**Action:** Always implement a `_isLoading` state combined with `CircularProgressIndicator` on submission buttons for async operations like Firebase Auth calls. Configure all `TextField` widgets with the appropriate keyboard type and action to streamline form completion on mobile devices.
## 2024-06-01 - Consolidate client-side validation and loading states
**Learning:** When adding loading states to submission buttons (e.g., setting `_isLoading = true`), it's crucial to run all client-side validation (like checking for empty fields or password length) *before* toggling the loading state. If the loading state is set first and validation fails, the UI may get stuck in a loading state or require additional complex state management to reset.
**Action:** Always perform input validation and early returns inside button `onPressed` handlers prior to calling `setState(() { _isLoading = true; })`.

## 2026-05-28 - Added loading states and keyboard input enhancements to Auth screens
**Learning:** Asynchronous form submission buttons (like login or signup) should implement a loading state (e.g., displaying a `CircularProgressIndicator`) and disable the button while loading to prevent duplicate submissions and provide visual feedback. Configuring `TextField` widgets with appropriate `keyboardType` (e.g., `TextInputType.emailAddress`) and `textInputAction` attributes significantly improves the mobile data entry experience.
**Action:** Always check form screens for missing loading states on submit buttons and missing keyboard configuration on input fields.
## 2026-05-27 - Added tooltip to IconButton
**Learning:** In Flutter, adding a `tooltip` property to an `IconButton` serves a dual purpose: it provides a visual hint on hover/long-press AND it acts as a semantic label for screen readers, similar to an ARIA label in web development. This is a highly effective, low-effort micro-UX improvement for accessibility.
**Action:** Always look for icon-only buttons in Flutter apps and ensure they have a `tooltip` property defined.
