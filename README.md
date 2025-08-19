# PocketTasks – Assignment

The **HomeScreen** is the main interface of the PocketTasks app.  
It provides users with the ability to **add tasks, search tasks, filter tasks, view task completion progress, and manage tasks** (mark as done or delete).

---

## Features

- **Add Task**
  - Users can type in a task and press the **Add** button to save it.
  - Validation ensures empty tasks cannot be added.
  - After adding, a success snackbar is shown.

- **Search Task**
  - A search bar allows users to quickly find tasks.
  - If no match is found, appropriate messages are displayed (e.g., *No Tasks*).

- **Task Filters**
  - Toggle between **All**, **Active**, and **Completed** tasks.
  - Active filter buttons are highlighted.

- **Task Completion Indicator**
  - Displays a circular progress indicator with percentage and count (`x/y`).
  - Shows overall completion progress.

- **Task List**
  - Displays tasks with title, creation date, and completion status.
  - Tasks can be marked as completed or active with a checkbox-style icon.
  - Tasks can be deleted, with an **Undo** option in the snackbar.

- **Snackbar Messages**
  - Provides real-time feedback for adding, deleting, and validation errors.

---

## UI Screenshot


---


## Code Highlights

- **State Management**: Uses `Flutter_riverpod` providers for tasks, filters, search, and completion status.
- **Snackbar Utility**: Centralized snackbar widget for success, error, and undo actions.
- **Custom Widgets**:
  - `CustomTextField` for consistent styled input.
  - `CirclePainter` for custom circular progress indicator.
  - `button` for reusable button styles.

---

## Example Flow

1. User enters **“Buy groceries”** in the input field → presses **Add**.
2. Task appears in the list with the current date.
3. User searches “groceries” → Task is shown.
4. User marks task as completed → Progress indicator updates.
5. User deletes task → Snackbar appears with **Undo** option.

---

## Tech Stack

- **Flutter** (UI framework)
- **Shared_preferences** (For storing tasks) 
- **Flutter_riverpod** (State management)

---



