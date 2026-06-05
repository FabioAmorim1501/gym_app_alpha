## 2024-03-24 - Async Form Feedback and Input Types in Auth Screens
**Learning:** During testing of the gym app's authentication screens, it became apparent that submitting login/signup forms without a loading indicator could lead to duplicate submissions and confused users. Furthermore, without proper `keyboardType` (`TextInputType.emailAddress`) and `textInputAction` (`TextInputAction.next`/`done`) configured, the mobile keyboard experience felt disjointed.
**Action:** Always implement a `_isLoading` state combined with `CircularProgressIndicator` on submission buttons for async operations like Firebase Auth calls. Configure all `TextField` widgets with the appropriate keyboard type and action to streamline form completion on mobile devices.
## 2026-05-28 - Added loading states and keyboard input enhancements to Auth screens
**Learning:** Asynchronous form submission buttons (like login or signup) should implement a loading state (e.g., displaying a `CircularProgressIndicator`) and disable the button while loading to prevent duplicate submissions and provide visual feedback. Configuring `TextField` widgets with appropriate `keyboardType` (e.g., `TextInputType.emailAddress`) and `textInputAction` attributes significantly improves the mobile data entry experience.
**Action:** Always check form screens for missing loading states on submit buttons and missing keyboard configuration on input fields.
## 2026-05-27 - Added tooltip to IconButton
**Learning:** In Flutter, adding a `tooltip` property to an `IconButton` serves a dual purpose: it provides a visual hint on hover/long-press AND it acts as a semantic label for screen readers, similar to an ARIA label in web development. This is a highly effective, low-effort micro-UX improvement for accessibility.
**Action:** Always look for icon-only buttons in Flutter apps and ensure they have a `tooltip` property defined.
## 2026-05-29 - Improved Empty State and Form UX in Create Training Plan
**Learning:** Displaying an empty list without context is a poor user experience. An empty state message (e.g., "No exercises added yet. Add one above!") provides helpful guidance. Additionally, failing to clear form input fields after appending an item forces the user to manually delete old text, adding unnecessary friction.
**Action:** Always implement empty state fallbacks for dynamic lists like `ListView.builder`. Always clear `TextEditingController` fields after successfully submitting or appending user input in a form.
## 2026-05-30 - Form inputs missing visual recognition
**Learning:** Textfields missing clear icons on mobile applications present poor UX and reduce visual recognition of what should be input into the forms.
**Action:** Always verify all forms contain descriptive placeholder icons via the `prefixIcon` parameter inside the InputDecoration.
