# Flutter App Architecture - Visual Guide

## The Three Trees: Widget, Element, Render

### 1. WIDGET TREE (What You Write)
```
StatelessWidget         StatefulWidget
    |                        |
    |                        |
 build()                createState()
    |                        |
    v                        v
Returns:              Returns State:
Widget tree          ├─ build() method
(immutable)          └─ state data
```

### 2. ELEMENT TREE (What Flutter Creates)
```
Each Widget → Becomes an Element

ToDoApp (Widget)
    ↓
ToDoAppElement (Element)
    ├─ reference to ToDoApp widget
    ├─ BuildContext
    ├─ isDirty flag
    └─ rebuild() method
```

### 3. RENDER TREE (What Gets Drawn)
```
Element
    ↓
RenderObject
    ├─ position on screen
    ├─ size
    ├─ visual properties
    └─ paint() - draws pixels
```

---

## The Update Cycle

```
┌─────────────────────────────────────────────────┐
│         USER INTERACTION                        │
│  (tap, type, gesture, etc.)                     │
└────────────────┬────────────────────────────────┘
                 │
                 v
        ┌────────────────┐
        │  onPressed()   │  <- You write this
        │  callback      │
        └────────┬───────┘
                 │
                 v
        ┌────────────────┐
        │ setState()     │  <- Signals change
        │ {...}          │
        └────────┬───────┘
                 │
                 v
    ┌────────────────────────┐
    │ Element.markNeedsBuild │  <- Mark as dirty
    └────────────┬───────────┘
                 │
                 v
    ┌────────────────────────┐
    │ build() called         │  <- New widgets created
    └────────────┬───────────┘
                 │
                 v
    ┌────────────────────────┐
    │ Widget Diff            │  <- Compare trees
    │ (old vs new)           │
    └────────────┬───────────┘
                 │
                 v
    ┌────────────────────────┐
    │ Update RenderObjects   │  <- Only changed parts
    └────────────┬───────────┘
                 │
                 v
    ┌────────────────────────┐
    │ paint()                │  <- Redraw screen
    │ (RenderObject)         │
    └────────────┬───────────┘
                 │
                 v
            ┌──────────┐
            │  SCREEN  │
            │ UPDATED  │
            └──────────┘
```

---

## Variable Types Memory Model

### `const` - One Instance Globally

```
Memory:
┌──────────────────────────────┐
│   CONSTANT POOL              │
│  (Compile-time)              │
│                              │
│  maxTitleLength = 50         │
│  emptyListMessage = "No..."  │
│  item1 = ToDoItem(...)       │
└──────────────────────────────┘
       ↑        ↑        ↑
       │        │        │
       │        │        └─ item1 reference #3
       │        └────────── item1 reference #2
       └───────────────── item1 reference #1

Every reference points to SAME object in memory!
```

### `final` - Per-Instance Reference

```
Instance of _ToDoHomeState #1:
┌─────────────────────────────┐
│  _toDoItems = [...]         │ <- Points to array
│  _titleController = { }     │ <- Points to controller
└─────────────────────────────┘

Instance of _ToDoHomeState #2:
┌─────────────────────────────┐
│  _toDoItems = [...]         │ <- Different array!
│  _titleController = { }     │ <- Different controller!
└─────────────────────────────┘

Each instance gets its own reference,
but reference itself can't be changed.
```

### `var` - Type Inferred

```
var appTitle = 'My To-Do App';
           ↓
    Dart infers: String
           ↓
    Becomes: String appTitle = 'My To-Do App';

var newItem = const ToDoItem(...);
       ↓
Dart infers: ToDoItem
       ↓
Becomes: ToDoItem newItem = const ToDoItem(...);
```

---

## Widget Composition Hierarchy

```
┌─────────────────────────────────────────────┐
│                   ToDoApp                   │  const
│                (StatelessWidget)             │  immutable
├─────────────────────────────────────────────┤
│  MaterialApp → ThemeData, navigation        │
└────────────────┬────────────────────────────┘
                 │
    Only contains:
    home: const ToDoHome()
                 │
                 v
┌─────────────────────────────────────────────┐
│                   ToDoHome                  │  const
│                (StatefulWidget)              │  → creates State
├─────────────────────────────────────────────┤
│  Holds: _ToDoHomeState (mutable state)      │
└────────────────┬────────────────────────────┘
                 │
    Contains (in build()):
    Scaffold (parent UI layout)
                 │
        ┌────────┴─────────┐
        │                  │
        v                  v
    ┌─────────┐        ┌──────────┐
    │  AppBar │        │ Column   │
    ├─────────┤        ├──────────┤
    │ Text    │        │ InputCard│ (const)
    └─────────┘        │ + List   │
                       └──────────┘
                             │
                         ListView.builder
                             │
                    ToDoItemWidget (const)
                    ┌────────────────────┐
                    │ Checkbox           │
                    │ Text (title)       │
                    │ IconButton (delete)│
                    └────────────────────┘
```

---

## State Flow Diagram

```
┌──────────────────────────────────────┐
│  _ToDoHomeState (State Object)       │
│  ├─ final List _toDoItems = []       │
│  ├─ var appTitle = '...'             │
│  └─ late final _titleController      │
└──────────────────────────────────────┘
          ↑              ↑
          │              │
    Holds │              │ Provides
    mutable              data
    state               
          │              │
          └──────┬───────┘
                 │
         ┌───────v──────────┐
         │  build() returns │
         │   Widget tree    │
         └─────────────────┘
                 │
              (When setState() called)
                 │
         ┌───────v──────────┐
         │ Element detected │
         │ tree changed     │
         └─────────────────┘
                 │
         ┌───────v──────────┐
         │ RenderObject     │
         │ updated          │
         └─────────────────┘
                 │
         ┌───────v──────────┐
         │ Screen redrawn   │
         └─────────────────┘
```

---

## Data Model: Immutability

```
class ToDoItem {
  final String title;
  final bool isCompleted;
  
  const ToDoItem({required this.title, required this.isCompleted});
}

When you "change" an item:
┌──────────────────────────────┐
│ OLD STATE:                   │
│ _toDoItems[0] = ToDoItem(    │
│   title: 'Task',             │
│   isCompleted: false         │
│ )                            │
└──────────────────────────────┘
           ↓ setState()
┌──────────────────────────────┐
│ NEW STATE:                   │
│ _toDoItems[0] = ToDoItem(    │  ← NEW object created
│   title: 'Task',             │
│   isCompleted: true          │
│ )                            │
└──────────────────────────────┘

Benefits:
✓ Flutter detects change (new object)
✓ Can safely compare objects
✓ Undo/redo easy (just keep old references)
✓ Thread-safe (immutable)
✓ Predictable behavior
```

---

## Rebuild Optimization

```
When setState() triggers rebuild:

OLD Widget Tree          NEW Widget Tree
│                        │
├─ ToDoApp              ├─ ToDoApp ← Same?
│  ├─ MaterialApp       │  ├─ MaterialApp ← Same?
│  │  └─ ToDoHome       │  │  └─ ToDoHome ← Same?
│  │     ├─ AppBar      │  │     ├─ AppBar ← Same?
│  │     │  └─ Text     │  │     │  └─ Text ← Same?
│  │     └─ ListView    │  │     └─ ListView
│  │        ├─ Item 1 ─ ┼──────────── Item 1 ← CHANGED!
│  │        ├─ Item 2   │  │        ├─ Item 2 ← Same?
│  │        └─ Item 3   │  │        └─ Item 3 ← Same?
│  │                    │  │

Diff Result:
✓ Item 1 changed → RenderObject updated → redrawn
✓ Item 2 unchanged → RenderObject reused → not redrawn
✓ Item 3 unchanged → RenderObject reused → not redrawn

Benefit: Efficient! Only 1 item redrawn instead of all 3.
```

---

## Building the App: Step by Step

```
Step 1: flutter run
           ↓
Step 2: main() called → runApp(const ToDoApp())
           ↓
Step 3: Widget tree created (ToDoApp at root)
           ↓
Step 4: Flutter creates Elements for each Widget
           ↓
Step 5: Elements call build() to get Widgets
           ↓
Step 6: Flutter creates RenderObjects from Widgets
           ↓
Step 7: RenderObjects paint to screen
           ↓
Step 8: USER SEES APP
           ↓
Step 9: User taps, types, interacts...
           ↓
Step 10: Callback fires → setState()
           ↓
        [CYCLES BACK TO: Element.markNeedsBuild()]
```

---

## Element Lifecycle

```
Widget created
    ↓
Element created
    ├─ initState() called
    ├─ build() called
    ├─ RenderObject created
    └─ Mounted on screen
    
        ↓
    
USER INTERACTION
    ├─ setState()
    ├─ Element marked dirty
    ├─ build() called again
    ├─ New Widget tree created
    ├─ diff performed
    └─ RenderObject updated
    
        ↓ (repeat for each interaction)
    
        ...more interactions...
    
        ↓
    
Close/Remove widget
    ├─ dispose() called
    ├─ cleanup resources
    ├─ Element removed
    └─ RenderObject destroyed
```

---

## Performance: const vs non-const

```
const ToDoItemWidget(item1, 0) → Only instance in memory
const ToDoItemWidget(item1, 0) → Reuses SAME instance
const ToDoItemWidget(item1, 0) → Reuses SAME instance

vs.

ToDoItemWidget(item1, 0) → New instance
ToDoItemWidget(item1, 0) → New instance
ToDoItemWidget(item1, 0) → New instance
                         ← Creates 3 objects for same data!

const = Single instance reused
non-const = New instance each time
```

---

## Summary: Memory & Performance

```
┌─────────────────────────────────┐
│  const: Global, single copy     │
│  ├─ Compile-time known          │
│  ├─ Zero runtime overhead       │
│  └─ Best performance            │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│  final: Per-instance immutable  │
│  ├─ Runtime set                 │
│  ├─ Reference never changes     │
│  └─ Good performance            │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│  var: Type inferred             │
│  ├─ Cleaner syntax              │
│  ├─ Same as explicit typing     │
│  └─ Good for local variables    │
└─────────────────────────────────┘

BEST PRACTICE:
1. Use const when possible
2. Use final for non-const immutables
3. Use var for type inference
4. Avoid var at class/function scope (use explicit types)
```

---

**This visual guide complements CONCEPTS.md - refer to both for complete understanding!**
