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
## 2026-06-06 - Enhanced TextFields with prefix icons and appropriate input types
**Learning:** Including a `prefixIcon` in `TextField` widgets (like an email or lock icon) provides immediate visual recognition for users, reducing cognitive load when filling out forms. Furthermore, explicitly setting `keyboardType` (e.g., `TextInputType.emailAddress`) and `textInputAction` appropriately, while turning off `autocorrect` for fields like emails, greatly streamlines mobile data entry.
**Action:** Always include a `prefixIcon` for common inputs and configure keyboard and action types to match the expected input.
## 2026-06-12 - Adding prefixIcons and textInputActions to Training Plan Form
**Learning:** When making multiple data entry fields, users navigate via the keyboard next button. Visual icons (like `prefixIcon`) greatly reduce cognitive load when identifying the purpose of dense form inputs in a mobile layout.
**Action:** Always include `prefixIcon` and appropriate `textInputAction` attributes (like `TextInputAction.next`) to multi-field forms.
