import 'package:flutter/material.dart';

class EditTodoDialog extends StatefulWidget {
  final String title;

  const EditTodoDialog({super.key, required this.title});

  @override
  State<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.title);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('编辑任务'),

      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: '请输入任务标题',
          border: OutlineInputBorder(),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('取消'),
        ),

        ElevatedButton(
          onPressed: () {
            final title = controller.text.trim();

            if (title.isEmpty) {
              return;
            }

            Navigator.pop(context, title);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
