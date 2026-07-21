import 'package:flutter/material.dart';
import '../controllers/todo_controller.dart';

class ChangeNotifierProvider extends StatefulWidget {
  final Widget child;

  const ChangeNotifierProvider({super.key, required this.child});

  @override
  State<ChangeNotifierProvider> createState() => _TodoProviderState();
}

class _TodoProviderState extends State<ChangeNotifierProvider> {
  late TodoController controller;
  int _version = 0;

  @override
  void initState() {
    super.initState();

    controller = TodoController();

    controller.addListener(_handleControllerChanged);
  }

  void _handleControllerChanged() {
    debugPrint('Provider监听到了变化');
    _version++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _TodoInherited(
      controller: controller,
      version: _version,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}

class _TodoInherited extends InheritedWidget {
  final TodoController controller;

  final int version;

  const _TodoInherited({
    required this.controller,
    required this.version,
    required super.child,
  });

  @override
  bool updateShouldNotify(_TodoInherited oldWidget) {
    return version != oldWidget.version;
  }
}

class TodoProvider {
  static TodoController of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_TodoInherited>();

    return inherited!.controller;
  }
}
