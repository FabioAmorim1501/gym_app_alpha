## 2024-05-28 - Un-disposed TextEditingControllers
**Learning:** Found that `TextEditingController`s in `StatefulWidget`s across the app were not being disposed, leading to memory leaks when navigating between screens.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (like `TextEditingController`) when the widget is removed from the widget tree to prevent memory leaks.
## 2024-05-24 - Flutter Memory Leaks from Missing Controller Disposal
**Learning:** Forgetting to dispose `TextEditingController` objects in StatefulWidgets is a common source of memory leaks in Flutter applications. When a widget is destroyed without disposing its controllers, the controller and any associated listeners remain in memory. Over time, navigating between screens creates multiple instances of these controllers, leading to higher memory consumption. This increases Garbage Collection (GC) pressure, which manifests as jank (dropped frames) during animations and scrolling. This app has numerous screens failing to dispose their controllers.
**Action:** Always implement the `dispose()` method in `StatefulWidget`s to clean up controllers (`TextEditingController`, `AnimationController`, `ScrollController`, etc.) when the widget is removed from the widget tree.

## 2024-06-05 - ValueNotifier for Form Performance Optimization
**Learning:** Calling `setState` at the root of a complex Flutter form widget rebuilds all descendant widgets, including expensive `TextField`s. This is highly inefficient when only a small portion of the UI (like a dynamic list of added items) needs to be updated.
**Action:** Isolate localized reactive state (e.g., dynamic lists) using `ValueNotifier` and wrap the specific dependent UI in a `ValueListenableBuilder`. This prevents unnecessary entire form rebuilds and significantly improves performance during data entry.

## 2024-07-26 - ListView.builder Performance Optimization
**Learning:** Calculating layout extents dynamically for every item in a `ListView.builder` can cause scroll jank, especially for long lists. If all items have the same structure (e.g., a `ListTile`), the layout calculations can be optimized.
**Action:** Always use the `prototypeItem` property in `ListView.builder` when all items have the same extent. This allows the list to pre-calculate the layout extent once based on the prototype, significantly reducing layout calculations during scrolling. Combine this with `maxLines: 1` and `overflow: TextOverflow.ellipsis` on textual content to ensure consistent item heights.
