# Professional Flutter Project Structure

## Overview

This to-do app has been refactored into a professional, scalable folder structure following Flutter best practices. Each widget, model, and constant is organized in its own file for maintainability and reusability.

---

## Project Structure

```
lib/
├── main.dart                    # Entry point only (minimal)
├── app/
│   └── todo_app.dart           # Root widget (MaterialApp)
├── screens/
│   └── todo_home.dart          # Main screen (StatefulWidget)
├── widgets/
│   ├── input_card.dart         # Input widget (StatelessWidget)
│   └── todo_item_widget.dart   # Item display (StatelessWidget)
├── models/
│   └── todo_item.dart          # Data model (immutable)
└── constants/
    └── app_constants.dart      # Global constants
```

---

## File Descriptions

### `lib/main.dart` (Entry Point)
- **Purpose**: App entry point only
- **Responsibility**: Call `runApp()` with ToDoApp
- **Line Count**: ~20 lines (minimal and clean)
- **What It Shows**:
  - How `const` optimization works at app startup
  - Clean separation of concerns
  - Professional main.dart pattern

```dart
import 'package:flutter/material.dart';
import 'app/todo_app.dart';

void main() {
  runApp(const ToDoApp());
}
```

### `lib/app/todo_app.dart` (Root Widget)
- **Purpose**: Root widget wrapping MaterialApp
- **Type**: StatelessWidget
- **Responsibility**: Theme, routing, app configuration
- **What It Shows**:
  - `const` constructor for optimization
  - Widget tree architecture at app level
  - Theme configuration

```dart
class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      theme: ThemeData(...),
      home: const ToDoHome(),
    );
  }
}
```

### `lib/screens/todo_home.dart` (Main Screen)
- **Purpose**: Home screen container
- **Type**: StatefulWidget with State
- **Responsibility**: Business logic, state management, rendering
- **What It Shows**:
  - StatefulWidget/State pattern
  - `setState()` usage
  - `final`, `var`, and `late final` variable types
  - Widget tree composition
  - Element and render tree concepts

```dart
class ToDoHome extends StatefulWidget {
  const ToDoHome({Key? key}) : super(key: key);
  
  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  final List<ToDoItem> _toDoItems = [];      // final
  var appTitle = 'My To-Do App';              // var
  late final TextEditingController _controller; // late final
}
```

### `lib/widgets/input_card.dart` (Input Component)
- **Purpose**: Reusable input widget
- **Type**: StatelessWidget (no internal state)
- **Responsibility**: Render input UI, communicate via callbacks
- **What It Shows**:
  - Reusable widget pattern
  - `final` constructor parameters
  - Unidirectional data flow (up via callbacks)

```dart
class InputCard extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onAdd;
  final int maxLength;
  
  const InputCard({...});
}
```

### `lib/widgets/todo_item_widget.dart` (Item Display)
- **Purpose**: Individual to-do item widget
- **Type**: StatelessWidget
- **Responsibility**: Display item, respond to user actions
- **What It Shows**:
  - Presentational widget pattern
  - `final` fields (immutable)
  - Callback propagation to parent

```dart
class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;
  final int index;
  final Function(int) onToggle;
  final Function(int) onDelete;
  
  const ToDoItemWidget({...});
}
```

### `lib/models/todo_item.dart` (Data Model)
- **Purpose**: Immutable data class
- **Responsibility**: Represent a to-do item
- **What It Shows**:
  - Immutability pattern
  - `const` constructor
  - `final` fields
  - Why immutability matters in Flutter

```dart
class ToDoItem {
  final String title;
  final bool isCompleted;
  
  const ToDoItem({required this.title, required this.isCompleted});
}
```

### `lib/constants/app_constants.dart` (Configuration)
- **Purpose**: Global app constants
- **Responsibility**: Store all compile-time constants
- **What It Shows**:
  - `const` variables at module level
  - Single source of truth for constants
  - Memory efficiency (one copy globally)

```dart
const int maxTitleLength = 50;
const String emptyListMessage = 'No tasks yet. Add one!';
const String appTitle = 'My To-Do App';
const String appVersion = '1.0.0';
```

---

## Import Patterns

### Absolute Imports (Recommended)
```dart
import 'package:to_do_app/app/todo_app.dart';
import 'package:to_do_app/screens/todo_home.dart';
```

### Relative Imports (Used in this project)
```dart
import '../app/todo_app.dart';
import '../screens/todo_home.dart';
import '../models/todo_item.dart';
import '../widgets/input_card.dart';
```

### Aliased Imports (Used for constants)
```dart
import '../constants/app_constants.dart' as app_constants;

// Usage:
app_constants.maxTitleLength
app_constants.emptyListMessage
```

---

## Variable Types by Location

| Type | Usage | Example |
|------|-------|---------|
| **const** | Module-level constants | `app_constants.dart` |
| **final** | State fields, controllers | `_toDoItems = []` |
| **late final** | Lazily initialized finals | `_titleController` |
| **var** | Type inference | Local variables |

---

## Data Flow Architecture

```
main.dart (entry point)
    ↓
app/todo_app.dart (root widget)
    ↓
screens/todo_home.dart (state container)
    ├─ state: List<ToDoItem>
    ├─ callbacks: _addToDoItem(), _toggleComplete(), _deleteItem()
    └─ renders:
        ├─ AppBar (title from constants)
        ├─ InputCard (receives controller, callback)
        └─ ListView.builder
            └─ ToDoItemWidget (receives item, callbacks)

models/todo_item.dart (data model)
    ├─ Immutable
    ├─ const constructor
    └─ Used by _ToDoHomeState

constants/app_constants.dart (configuration)
    ├─ Global const values
    └─ Used by screens and widgets
```

---

## Scaling This Structure

For a larger app, extend with:

```
lib/
├── main.dart
├── app/
├── screens/
├── widgets/
├── models/
├── constants/
├── services/           # API, database, authentication
├── providers/          # State management (Provider, Riverpod)
├── utils/              # Helper functions, extensions
├── theme/              # Theme configuration
└── config/             # App configuration
```

---

## Benefits of This Structure

✅ **Maintainability**: Each file has clear responsibility
✅ **Scalability**: Easy to add features without cluttering
✅ **Reusability**: Widgets easily extracted and reused
✅ **Testing**: Each component can be tested independently
✅ **Collaboration**: Team members know where to find code
✅ **Performance**: Efficient imports, clear dependency graph
✅ **Documentation**: File organization self-documents code

---

## Running the App

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/

# Run tests
flutter test

# Run app
flutter run

# Run with specific device
flutter run -d <device-id>
```

---

## Next Steps

1. **Add Services Layer**
   ```
   lib/services/
   ├── todo_service.dart
   ├── storage_service.dart
   └── api_service.dart
   ```

2. **Add State Management**
   ```
   lib/providers/
   ├── todo_provider.dart
   └── app_provider.dart
   ```

3. **Organize Widgets Better**
   ```
   lib/widgets/
   ├── common/
   ├── todo/
   └── shared/
   ```

4. **Add Utilities**
   ```
   lib/utils/
   ├── validators.dart
   ├── extensions.dart
   └── helpers.dart
   ```

---

## File Import Checklist

✅ `main.dart` imports: `app/todo_app.dart`
✅ `app/todo_app.dart` imports: `screens/todo_home.dart`
✅ `screens/todo_home.dart` imports: `models/`, `widgets/`, `constants/`
✅ `widgets/*.dart` imports: `models/`, (no circular imports)
✅ `models/*.dart` imports: (no other local files)
✅ `constants/*.dart` imports: (only constants)

---

This professional structure makes your Flutter app scalable, maintainable, and a pleasure to work with!
