## 2024-05-28 - Un-disposed TextEditingControllers
**Learning:** Found that `TextEditingController`s in `StatefulWidget`s across the app were not being disposed, leading to memory leaks when navigating between screens.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (like `TextEditingController`) when the widget is removed from the widget tree to prevent memory leaks.
## 2024-05-24 - Flutter Memory Leaks from Missing Controller Disposal
**Learning:** Forgetting to dispose `TextEditingController` objects in StatefulWidgets is a common source of memory leaks in Flutter applications. When a widget is destroyed without disposing its controllers, the controller and any associated listeners remain in memory. Over time, navigating between screens creates multiple instances of these controllers, leading to higher memory consumption. This increases Garbage Collection (GC) pressure, which manifests as jank (dropped frames) during animations and scrolling. This app has numerous screens failing to dispose their controllers.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (`TextEditingController`, `AnimationController`, `ScrollController`, etc.) when the widget is removed from the widget tree.
## 2024-05-31 - Duplicate Authentication API Calls
**Learning:** The `AuthService` contained duplicate calls to `createUserWithEmailAndPassword` and `signInWithEmailAndPassword`, causing compilation errors and an unnecessary extra network request during login and sign-up flows.
**Action:** Always verify code for duplicate/redundant API calls when resolving compilation errors. Removing redundant network requests can cut latency significantly for core flows like authentication.
