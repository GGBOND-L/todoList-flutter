import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';

class TodoProvider extends InheritedWidget {
  final TodoController controller;

  const TodoProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static TodoProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoProvider>();
  }

  @override
  bool updateShouldNotify(TodoProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
