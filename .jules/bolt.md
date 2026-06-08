## 2024-05-28 - Un-disposed TextEditingControllers
**Learning:** Found that `TextEditingController`s in `StatefulWidget`s across the app were not being disposed, leading to memory leaks when navigating between screens.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (like `TextEditingController`) when the widget is removed from the widget tree to prevent memory leaks.
## 2024-05-24 - Flutter Memory Leaks from Missing Controller Disposal
**Learning:** Forgetting to dispose `TextEditingController` objects in StatefulWidgets is a common source of memory leaks in Flutter applications. When a widget is destroyed without disposing its controllers, the controller and any associated listeners remain in memory. Over time, navigating between screens creates multiple instances of these controllers, leading to higher memory consumption. This increases Garbage Collection (GC) pressure, which manifests as jank (dropped frames) during animations and scrolling. This app has numerous screens failing to dispose their controllers.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (`TextEditingController`, `AnimationController`, `ScrollController`, etc.) when the widget is removed from the widget tree.

## 2024-06-05 - ValueNotifier for Form Performance Optimization
**Learning:** Calling `setState` at the root of a complex Flutter form widget rebuilds all descendant widgets, including expensive `TextField`s. This is highly inefficient when only a small portion of the UI (like a dynamic list of added items) needs to be updated.
**Action:** Isolate localized reactive state (e.g., dynamic lists) using `ValueNotifier` and wrap the specific dependent UI in a `ValueListenableBuilder`. This prevents unnecessary entire form rebuilds and significantly improves performance during data entry.
## 2024-05-20 - ListView scroll performance optimization
**Learning:** Using `prototypeItem` in Flutter's `ListView.builder` for uniform items avoids calculating extents dynamically, yielding measurable frame rate improvements during fast scrolls.
**Action:** Always provide a `prototypeItem` or explicit `itemExtent` when rendering large lists with uniform item layouts.
