# Flutter To-Do App - Quick Start

## Setup & Run

```bash
# Get dependencies
flutter pub get

# Run on available device/emulator
flutter run

# Run with specific device
flutter run -d <device-id>

# Run on Android
flutter run -d emulator-5554

# Run on iOS (macOS only)
flutter run -d <iphone-device>

# Web (requires web support enabled)
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart          # Complete app with all concepts demonstrated
CONCEPTS.md            # Detailed explanation of all concepts
README.md              # This file
```

## What This App Demonstrates

### 1. Widget Tree Architecture
- StatelessWidget: `ToDoApp`, `InputCard`, `ToDoItemWidget`
- StatefulWidget: `ToDoHome` with `_ToDoHomeState`
- Proper widget composition and hierarchy

### 2. Element & Render Tree
- Element creation from widgets
- State management through Elements
- Efficient rebuild detection

### 3. Variable Types (var, final, const)

#### `const` - Compile-time constants
```dart
static const int maxTitleLength = 50;
const ToDoItem(title: 'Task', isCompleted: false);
const Icon(Icons.add);  // in widget tree
```
- Only one instance in memory
- Value known at compile time
- Best for true constants

#### `final` - Runtime constants
```dart
final List<ToDoItem> _toDoItems = [];
late final TextEditingController _titleController;
```
- Set once, never reassigned
- Can be initialized at runtime
- Reference is immutable, but contents can change

#### `var` - Type inference
```dart
var appTitle = 'My To-Do App';
var item = _toDoItems[0];
```
- Type inferred from assigned value
- Cleaner, shorter code
- Same performance as explicit types

### 4. State Mutation & Memory
- Immutable `ToDoItem` data class with `const` constructor
- Creating new instances instead of modifying existing ones
- Proper `setState()` usage

---

## Code Highlights

### Architecture Flow
```txt
1. User Action (tap, type)
   ↓
2. onPressed/onChanged callback
   ↓
3. setState() called
   ↓
4. Element marked dirty
   ↓
5. build() called
   ↓
6. New Widget tree created
   ↓
7. Element diffs trees
   ↓
8. RenderObject updated
   ↓
9. Screen redraws
```

### Variable Declaration Examples

```dart
// ALWAYS use const for constructors when possible
const ToDoItemWidget(
  item: item,
  index: index,
  onToggle: _toggleComplete,
  onDelete: _deleteItem,
)

// Use final for state fields
final List<ToDoItem> _toDoItems = [];
final TextController controller;  // initialized in initState

// Use var for type inference
var appTitle = 'My To-Do App';  // inferred as String
var item = _toDoItems[0];        // inferred as ToDoItem

// Use const for true constants
const maxLength = 50;
```

---

## Key Features Explained

### InputCard Widget
- **Type**: StatelessWidget (no internal state)
- **Purpose**: Reusable input component
- **Data Flow**: Text input → callback to parent

```dart
InputCard(
  controller: _titleController,    // final field
  onAdd: _addToDoItem,              // callback
  maxLength: maxTitleLength,        // const
)
```

### ToDoItemWidget
- **Type**: StatelessWidget (purely presentational)
- **Purpose**: Display single to-do item
- **Interaction**: Checkbox, delete button trigger callbacks

### _ToDoHomeState
- **Type**: State<ToDoHome> (manages mutable state)
- **Purpose**: Main app logic, maintain to-do list
- **Variables**: Mix of const, final, and var

---

## Learning Path

1. **Read CONCEPTS.md** - Understand widget/element/render trees
2. **Read the code comments** in [main.dart](lib/main.dart)
3. **Run the app** - Add items, delete items, toggle completion
4. **Use Hot Reload** (`R` key) - See how widgets update
5. **Experiment**:
   - Add logging to see when widgets rebuild
   - Change `var` to explicit types and compare
   - Try removing `const` from constructors

---

## Hot Reload & Hot Restart

**Hot Reload** (`R` in terminal):
- Recompiles Dart code
- Preserves app state
- Elements remain intact
- Great for UI changes

**Hot Restart** (`Shift+R` in terminal):
- Full app restart
- Clears all state
- Use when logic changes affect initialization

---

## Dart Syntax Reference

### Variable Declarations
```dart
const int x = 10;           // Compile-time constant
final int y = getValue();   // Runtime constant
var z = 10;                 // Type inferred (int)
int w = 10;                 // Explicit type

// Collections
final List<String> items = [];        // immutable ref, mutable content
const List<String> items = ['a'];     // immutable ref & content
```

### Function
```dart
void _addToDoItem(String title) { }   // returns nothing
ToDoItem _getItem(int index) { }      // returns ToDoItem

// Optional/named parameters
const InputCard({
  Key? key,                           // required, nullable
  required String controller,         // required, non-null
}) : super(key: key);
```

### Classes
```dart
class ToDoItem {
  final String title;           // immutable field
  const ToDoItem({required this.title});  // const constructor
}

class _ToDoHomeState extends State<ToDoHome> {
  late final TextController _controller;  // initialized later
}
```

---

## Troubleshooting

### App won't run
```bash
# Clean build
flutter clean
flutter pub get
flutter run
```

### Hot reload not working
- Try Hot Restart (`Shift+R`)
- Rebuild might have issues with const changes

### Memory issues with large lists
- Use `ListView.builder` instead of `ListView` (app already does this)
- Consider pagination for huge lists

### Build errors
```bash
# Check for issues
flutter analyze

# Format code
dart format lib/
```

---

## Next Steps

1. **Add persistence**: Save to-dos to local storage
2. **Add dates**: Add due dates to tasks
3. **Categorize**: Group to-dos by category
4. **Provider/Riverpod**: Explore state management packages
5. **Tests**: Add unit and widget tests

---

## References

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [State Management Guide](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)
