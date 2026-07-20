import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../enums/todo_filter.dart';

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

  void _showEditDialog(Todo todo) {
    debugPrint('编辑待办事项：${todo.id}');

    // 创建一个 TextEditingController 用于编辑，赋值
    final controller = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) {
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
  }

  void handleCompleteTodo(Todo todo) {
    debugPrint('完成待办事项：${todo.id}');

    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  void handleFilter(TodoFilter filter, String title) {
    debugPrint('过滤待办事项：$title, filter: $filter');

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

            _buildUserCard(),

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

  // 用户信息卡片
  Widget _buildUserCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('当前用户信息卡片'),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person, size: 64),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('用户名'), Text('邮箱')],
              ),
            ],
          ),
        ],
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
        _buildTaskCard('全部任务', todos.length, const Icon(Icons.list)),
        _buildTaskCard(
          '已完成',
          todos.where((todo) => todo.isCompleted).length,
          const Icon(Icons.done),
        ),
        _buildTaskCard(
          '未完成',
          todos.where((todo) => !todo.isCompleted).length,
          const Icon(Icons.close),
        ),
        _buildTaskCard(
          '完成率',
          todos.isEmpty
              ? 0
              : (todos.where((todo) => todo.isCompleted).length /
                        todos.length *
                        100)
                    .toInt(),
          const Icon(Icons.percent),
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
              child: _buildTaskFilterCard(
                '全部任务',
                TodoFilter.all,
                selectedFilter == TodoFilter.all,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTaskFilterCard(
                '已完成',
                TodoFilter.completed,
                selectedFilter == TodoFilter.completed,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTaskFilterCard(
                '未完成',
                TodoFilter.incomplete,
                selectedFilter == TodoFilter.incomplete,
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
        const Text(
          '我的待办',
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: '输入新的待办事项,例如:学习 Flutter',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: todoController,
              ),
            ),

            const SizedBox(width: 12), // 间距

            ElevatedButton(onPressed: handleAddTodo, child: const Text('添加')),
          ],
        ),

        const SizedBox(height: 12),

        // 待办事项list
        // _buildTaskItem('学习 Flutter', true, '2023-06-01'),

        // const SizedBox(height: 12),

        // _buildTaskItem('学习 Dart', false, '2023-06-02'),
        ...filteredTodos.map((todo) => _buildTaskItem(todo)),
      ],
    );
  }

  // 任务统计小卡片
  Widget _buildTaskCard(String title, int count, Widget icon) {
    return Container(
      // 样式装饰器
      decoration: BoxDecoration(
        color: Colors.white, // 盒子的底色
        // 核心：在这里给小盒子添加边框
        border: Border.all(
          color: Colors.blueAccent, // 边框颜色
          width: 1.5, // 边框粗细
        ),

        // 可选：加个圆角让边框更好看
        borderRadius: BorderRadius.circular(8.0),
      ),

      // 盒子的内边距
      padding: const EdgeInsets.all(16.0),

      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('$count'), Text(title)],
          ),
        ],
      ),
    );
  }

  // 任务筛选小卡片
  Widget _buildTaskFilterCard(String title, TodoFilter filter, bool selected) {
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
          handleFilter(filter, title);
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

  Widget _buildTaskItem(Todo todo) {
    return Container(
      // 优化 1：去掉硬编码的 height: 80.0，改用我们第一节聊到的最小高度 constraints
      // 这样内容少时它是小盒子，放了编辑按钮也能平滑撑开，绝不溢出
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
        leading: Checkbox(
          onChanged: (value) => handleCompleteTodo(todo),
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
                _showEditDialog(todo);
              },
              icon: const Icon(Icons.edit, color: Colors.blueGrey, size: 20),
            ),
            // 删除按钮
            IconButton(
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(8),
              onPressed: () => handleDeleteTask(todo.id),
              icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
