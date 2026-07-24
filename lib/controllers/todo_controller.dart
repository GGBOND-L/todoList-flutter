import 'package:flutter/material.dart';
import '../enums/todo_filter.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';

class TodoController extends ChangeNotifier {
  final TodoRepository repository;

  TodoController(this.repository);
  // Todo列表状态
  final List<Todo> _todos = [];

  Future<void> loadTodos() async {
    final todos = await repository.fetchTodos();

    _todos
      ..clear()
      ..addAll(todos);

    notifyListeners();
  }

  // 当前筛选状态
  TodoFilter _filter = TodoFilter.all;

  TodoFilter get filter => _filter;

  List<Todo> get todos => List.unmodifiable(_todos);
  // 为什么使用unmodifiable：防止外部修改 Controller 内部状态。
  // List<Todo> get todos => _todos;
  // 使用controller.todos

  // 等价
  // List<Todo> getTodos() {
  //   return _todos;
  // }

  List<Todo> get filteredTodos {
    switch (_filter) {
      case TodoFilter.completed:
        return _todos.where((todo) => todo.isCompleted).toList();

      case TodoFilter.incomplete:
        return _todos.where((todo) => !todo.isCompleted).toList();

      default:
        return _todos;
    }
  }

  int get completedCount {
    return _todos.where((todo) => todo.isCompleted).length;
  }

  int get incompleteCount {
    return _todos.where((todo) => !todo.isCompleted).length;
  }

  int get completedRate {
    if (_todos.isEmpty) {
      return 0;
    }

    return (completedCount / _todos.length * 100).toInt();
  }

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      isCompleted: false,
      createdAt: DateTime.now().toString(),
    );

    _todos.add(todo);

    // 这是必须要写的吗？
    notifyListeners();
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);

    notifyListeners();
  }

  void toggleTodo(int id) {
    final todo = _todos.firstWhere((todo) => todo.id == id);

    todo.isCompleted = !todo.isCompleted;

    notifyListeners();
  }

  void changeFilter(TodoFilter filter) {
    _filter = filter;

    notifyListeners();
  }

  void updateTodoTitle(int id, String title) {
    final todo = _todos.firstWhere((todo) => todo.id == id);

    todo.title = title;

    notifyListeners();
  }
}
