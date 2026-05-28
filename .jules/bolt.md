## 2024-05-28 - Un-disposed TextEditingControllers
**Learning:** Found that `TextEditingController`s in `StatefulWidget`s across the app were not being disposed, leading to memory leaks when navigating between screens.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (like `TextEditingController`) when the widget is removed from the widget tree to prevent memory leaks.
