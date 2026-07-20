import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  final VoidCallback onDelete;

  final VoidCallback onEdit;

  final VoidCallback onToggle;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onDelete,
    required this.onEdit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 70.0),
      margin: const EdgeInsets.symmetric(vertical: 6), // 列表项之间的上下外边距
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(
          color: Colors.blueAccent.withAlpha(100), // 弱化一下边框颜色视觉更好
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      // 优化 2：使用 ListTile 替代自己手写的复杂 Column/Row
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

        // 左侧放置：复选框
        // 为什么会报错提示: The argument type 'void Function()' can't be assigned to the parameter type 'ValueChanged<bool?>?'.
        // leading: Checkbox(onChanged: () => onToggle(), value: todo.isCompleted),
        leading: Checkbox(
          onChanged: (_) => onToggle(),
          value: todo.isCompleted,
        ),

        // 中间主体：标题
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // 如果完成了，加个好看的删除线效果
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : Colors.black87,
          ),
        ),

        // 中间副标题：日期
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            todo.createdAt,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),

        // 右侧放置：操作按钮区域
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // 核心：必须限制 Row 只占用内部图标的大小
          children: [
            // 编辑按钮
            IconButton(
              constraints: const BoxConstraints(), // 紧凑型按钮，减小默认的 48 像素大外边距
              padding: const EdgeInsets.all(8),
              onPressed: () {
                onEdit();
              },
              icon: const Icon(Icons.edit, color: Colors.blueGrey, size: 20),
            ),
            // 删除按钮
            IconButton(
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(8),
              onPressed: () => onDelete(),
              icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
