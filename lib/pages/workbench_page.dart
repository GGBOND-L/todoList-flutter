import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../enums/todo_filter.dart';
import '../widgets/todo_item.dart';
import '../widgets/todo_stat_card.dart';
import '../widgets/todo_filter_button.dart';
import '../widgets/user_card.dart';
import '../widgets/todo_input.dart';

class WorkbenchPage extends StatefulWidget {
  const WorkbenchPage({super.key});

  @override
  State<WorkbenchPage> createState() => _WorkbenchPageState();
}

class _WorkbenchPageState extends State<WorkbenchPage> {
  final List<Todo> todos = [
    Todo(
      id: '1',
      title: '学习 Flutter122',
      isCompleted: true,
      createdAt: '2023-06-01',
    ),
    Todo(
      id: '2',
      title: '学习 Dart2222211',
      isCompleted: false,
      createdAt: '2023-06-02',
    ),
  ];

  TodoFilter selectedFilter = TodoFilter.all; // selectedFilter = '全部';

  List<Todo> get filteredTodos {
    switch (selectedFilter) {
      case TodoFilter.all:
        return todos;
      case TodoFilter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case TodoFilter.incomplete:
        return todos.where((todo) => !todo.isCompleted).toList();
    }
  }

  final TextEditingController todoController = TextEditingController();

  void handleAddTodo() {
    final String title = todoController.text.trim();
    debugPrint('添加待办事项：$title');

    if (title.isNotEmpty) {
      setState(() {
        todos.add(
          Todo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            isCompleted: false,
            createdAt: DateTime.now().toString(),
          ),
        );
        todoController.clear(); // 清空输入框
      });
    }
  }

  void handleDeleteTask(String id) {
    debugPrint('删除待办事项：$id');
    if (id.isNotEmpty) {
      setState(() {
        todos.removeWhere((todo) => todo.id == id);
      });
    }
  }

  Future<void> _showEditDialog(Todo todo) async {
    debugPrint('编辑待办事项：${todo.id}');

    // 创建一个 TextEditingController 用于编辑，赋值
    final controller = TextEditingController(text: todo.title);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
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
                Navigator.pop(dialogContext);
              },
              child: const Text('取消'),
            ),

            ElevatedButton(
              onPressed: () {
                final newTitle = controller.text.trim();

                if (newTitle.isEmpty) {
                  return;
                }

                setState(() {
                  todo.title = newTitle;
                });

                Navigator.pop(context);
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );

    controller.dispose();
  }

  void handleCompleteTodo(Todo todo) {
    debugPrint('完成待办事项：${todo.id}');

    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  void handleFilter(TodoFilter filter) {
    debugPrint('过滤待办事项：filter: $filter');

    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('工作台')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 12),

            const Text(
              '认真对待每一天',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),

            const SizedBox(height: 24),

            const UserCard(username: '用户名', email: '邮箱'),

            const SizedBox(height: 32),

            // 任务统计区域
            _buildStatisticsSection(),

            const SizedBox(height: 32),

            _buildFilterSection(),

            const SizedBox(height: 32),

            // 我的待办事项区域
            _buildTodoSection(),
          ],
        ),
      ),
    );
  }

  // 任务统计卡片
  Widget _buildStatisticsSection() {
    return GridView.count(
      // 核心：强制网格紧凑包裹内容，防止无限高度报错
      shrinkWrap: true,
      // 核心：禁用 GridView 自身的滚动（通常交由外层去滚动）
      physics: const NeverScrollableScrollPhysics(),

      // 相当于 CSS 的 grid-template-columns: repeat(2, 1fr)
      crossAxisCount: 2,

      // 相当于 CSS 的 row-gap (上下间距)
      mainAxisSpacing: 16.0,
      // 相当于 CSS 的 column-gap (左右间距)
      crossAxisSpacing: 16.0,

      // 控制整个网格的外边距
      // padding: const EdgeInsets.all(16.0),

      // 可选：控制子元素的宽高比（默认 1.0 为正方形，如果需要矩形可以调整，比如 2.0 代表宽是高的两倍）
      childAspectRatio: 1.5,

      children: [
        // _buildTaskCard('全部任务', todos.length, const Icon(Icons.list)),
        TodoStatCard(
          title: '全部任务',
          total: todos.length,
          icon: const Icon(Icons.list),
        ),
        TodoStatCard(
          title: '已完成',
          total: todos.where((todo) => todo.isCompleted).length,
          icon: const Icon(Icons.done),
        ),
        TodoStatCard(
          title: '未完成',
          total: todos.where((todo) => !todo.isCompleted).length,
          icon: const Icon(Icons.close),
        ),
        TodoStatCard(
          title: '完成率',
          total: todos.isEmpty
              ? 0
              : (todos.where((todo) => todo.isCompleted).length /
                        todos.length *
                        100)
                    .toInt(),
          icon: const Icon(Icons.percent),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '任务筛选',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              // child: _buildTaskFilterCard(
              //   '全部任务',
              //   TodoFilter.all,
              //   selectedFilter == TodoFilter.all,
              // ),
              child: TodoFilterButton(
                filter: TodoFilter.all,
                title: '全部任务',
                selected: selectedFilter == TodoFilter.all,
                onTap: (value) => handleFilter(value),
                // onTap: handleFilter, // 为什么onTap: (value) => handleFilter(value),onTap: handleFilter都可以
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TodoFilterButton(
                filter: TodoFilter.completed,
                title: '已完成',
                selected: selectedFilter == TodoFilter.completed,
                onTap: (value) => handleFilter(value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TodoFilterButton(
                filter: TodoFilter.incomplete,
                title: '未完成',
                selected: selectedFilter == TodoFilter.incomplete,
                onTap: (value) => handleFilter(value),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 我的待办事项区域
        TodoInput(controller: todoController, onAdd: handleAddTodo),

        const SizedBox(height: 12),

        // 待办事项list
        // _buildTaskItem('学习 Flutter', true, '2023-06-01'),

        // const SizedBox(height: 12),

        // _buildTaskItem('学习 Dart', false, '2023-06-02'),
        // ...filteredTodos.map((todo) {
        //   return TodoItem(todo: todo, onDelete:() => handleDeleteTask(todo.id), onToggle: () => handleCompleteTodo(todo), onEdit: () => _showEditDialog(todo),)
        // })
        ...filteredTodos.map(
          (todo) => TodoItem(
            todo: todo,
            onDelete: () => handleDeleteTask(todo.id),
            onToggle: () => handleCompleteTodo(todo),
            onEdit: () => _showEditDialog(todo),
          ),
        ),
      ],
    );
  }
}
