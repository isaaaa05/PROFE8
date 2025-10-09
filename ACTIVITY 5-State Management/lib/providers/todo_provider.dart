import 'package:flutter/foundation.dart';
import '../models/todo_item.dart';

// COMPONENT 5: To-do list app using Provider for state management
// COMPONENT 2: ChangeNotifier to update UI when data changes
class TodoProvider with ChangeNotifier {
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  int get todoCount => _todos.length;

  int get completedCount => _todos.where((todo) => todo.isCompleted).length;

  // COMPONENT 5: Add todo item
  void addTodo(String title, String description) {
    _todos.add(TodoItem(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    ));
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index >= 0) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      // COMPONENT 2: Notify listeners to update UI
      notifyListeners();
    }
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    // COMPONENT 2: Notify listeners to update UI
    notifyListeners();
  }
}
