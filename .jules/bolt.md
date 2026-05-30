## 2024-05-30 - [Memory Leaks in Flutter Forms]
**Learning:** Forgetting to explicitly dispose of `TextEditingController` instances in `StatefulWidget`s leads to memory leaks because they hold onto native resources that Flutter doesn't automatically release.
**Action:** Always implement a `dispose()` method in `StatefulWidget`s to clean up controllers when the widget is removed from the widget tree.
