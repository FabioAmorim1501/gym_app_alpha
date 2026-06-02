## 2024-03-24 - Async Form Feedback and Input Types in Auth Screens
**Learning:** During testing of the gym app's authentication screens, it became apparent that submitting login/signup forms without a loading indicator could lead to duplicate submissions and confused users. Furthermore, without proper `keyboardType` (`TextInputType.emailAddress`) and `textInputAction` (`TextInputAction.next`/`done`) configured, the mobile keyboard experience felt disjointed.
**Action:** Always implement a `_isLoading` state combined with `CircularProgressIndicator` on submission buttons for async operations like Firebase Auth calls. Configure all `TextField` widgets with the appropriate keyboard type and action to streamline form completion on mobile devices.
## 2026-05-28 - Added loading states and keyboard input enhancements to Auth screens
**Learning:** Asynchronous form submission buttons (like login or signup) should implement a loading state (e.g., displaying a `CircularProgressIndicator`) and disable the button while loading to prevent duplicate submissions and provide visual feedback. Configuring `TextField` widgets with appropriate `keyboardType` (e.g., `TextInputType.emailAddress`) and `textInputAction` attributes significantly improves the mobile data entry experience.
**Action:** Always check form screens for missing loading states on submit buttons and missing keyboard configuration on input fields.
## 2026-05-27 - Added tooltip to IconButton
**Learning:** In Flutter, adding a `tooltip` property to an `IconButton` serves a dual purpose: it provides a visual hint on hover/long-press AND it acts as a semantic label for screen readers, similar to an ARIA label in web development. This is a highly effective, low-effort micro-UX improvement for accessibility.
**Action:** Always look for icon-only buttons in Flutter apps and ensure they have a `tooltip` property defined.
## 2024-05-24 - Validate Forms Before Setting Loading States
**Learning:** Setting a form submission button to a loading/disabled state *before* running client-side validation logic locks the user out of the form if their input is invalid. This prevents them from fixing the errors and retrying, leading to a dead-end UI state.
**Action:** Always execute client-side validation checks before updating the UI to a loading state. Only transition to the loading state if all validation checks pass.
