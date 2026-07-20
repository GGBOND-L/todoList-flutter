import 'package:flutter/material.dart';
import '../enums/todo_filter.dart';

class TodoFilterButton extends StatelessWidget {
  final String title;
  final TodoFilter filter;
  final bool selected;
  // 点击回调
  final ValueChanged<TodoFilter> onTap;

  const TodoFilterButton({
    super.key,
    required this.title,
    required this.filter,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0, // 核心：在这里强制固定高度
      decoration: BoxDecoration(
        color: selected ? Colors.blueAccent : Colors.grey.shade50,

        border: Border.all(
          color: selected ? Colors.blueAccent : Colors.grey.shade300,
          width: 1.5,
        ),

        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      // child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      child: TextButton(
        onPressed: () {
          onTap(filter);
        },
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,

            color: selected ? Colors.white : Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
