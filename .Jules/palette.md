## 2026-05-28 - Added loading states and keyboard input enhancements to Auth screens
**Learning:** Asynchronous form submission buttons (like login or signup) should implement a loading state (e.g., displaying a `CircularProgressIndicator`) and disable the button while loading to prevent duplicate submissions and provide visual feedback. Configuring `TextField` widgets with appropriate `keyboardType` (e.g., `TextInputType.emailAddress`) and `textInputAction` attributes significantly improves the mobile data entry experience.
**Action:** Always check form screens for missing loading states on submit buttons and missing keyboard configuration on input fields.
## 2026-05-27 - Added tooltip to IconButton
**Learning:** In Flutter, adding a `tooltip` property to an `IconButton` serves a dual purpose: it provides a visual hint on hover/long-press AND it acts as a semantic label for screen readers, similar to an ARIA label in web development. This is a highly effective, low-effort micro-UX improvement for accessibility.
**Action:** Always look for icon-only buttons in Flutter apps and ensure they have a `tooltip` property defined.
