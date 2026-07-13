import 'package:flutter/material.dart';

class WorkbenPage extends StatelessWidget {
  const WorkbenPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('工作台')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const SizedBox(height: 32),

            const Text(
              '工作台',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              '认真对待每一天',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),

            const SizedBox(height: 24),

            // 当前用户信息卡片
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withValues(),
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16.0), // 内部间距
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
            ),

            const SizedBox(height: 32),

            // 任务统计区域
            GridView.count(
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
              padding: const EdgeInsets.all(16.0),

              // 可选：控制子元素的宽高比（默认 1.0 为正方形，如果需要矩形可以调整，比如 2.0 代表宽是高的两倍）
              childAspectRatio: 1.5,

              children: [
                _buildTaskCard('全部任务', 10, const Icon(Icons.list)),
                _buildTaskCard('已完成', 5, const Icon(Icons.done)),
                _buildTaskCard('未完成', 5, const Icon(Icons.close)),
                _buildTaskCard('完成率', 0, const Icon(Icons.percent)),
              ],
            ),

            const SizedBox(height: 32),

            // 任务筛选区域
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
                Expanded(child: _buildTaskFilterCard('全部任务')),
                const SizedBox(width: 12),
                Expanded(child: _buildTaskFilterCard('已完成')),
                const SizedBox(width: 12),
                Expanded(child: _buildTaskFilterCard('未完成')),
              ],
            ),

            const SizedBox(height: 32),

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
                  ),
                ),

                const SizedBox(width: 12), // 间距

                ElevatedButton(onPressed: () {}, child: const Text('添加')),
              ],
            ),

            const SizedBox(height: 12),

            // 待办事项list
            _buildTaskList('学习 Flutter', true, '2023-06-01'),

            const SizedBox(height: 12),

            _buildTaskList('学习 Dart', false, '2023-06-02'),
          ],
        ),
      ),
    );
  }
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
Widget _buildTaskFilterCard(String title) {
  return Container(
    height: 40.0, // 核心：在这里强制固定高度
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      border: Border.all(
        color: Colors.blueAccent, // 边框
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8.0), // 圆角
    ),
    alignment: Alignment.center,
    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

// 任务list
// Widget _buildTaskList(String title, bool completed, String date) {
//   return Container(
//     height: 80.0, // 核心：在这里强制固定高度
//     decoration: BoxDecoration(
//       color: Colors.grey.shade50,
//       border: Border.all(
//         color: Colors.blueAccent, // 边框
//         width: 1.5,
//       ),
//       borderRadius: BorderRadius.circular(8.0), // 圆角
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Checkbox(onChanged: (value) => {}, value: completed),
//             const SizedBox(width: 12),
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(width: 50),
//             Text('$completed'),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(date),
//         Row(
//           children: [
//             IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
//             IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
//           ],
//         ),
//       ],
//     ),
//   );
// }
Widget _buildTaskList(String title, bool completed, String date) {
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
      leading: Checkbox(onChanged: (value) => {}, value: completed),

      // 中间主体：标题
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // 如果完成了，加个好看的删除线效果
          decoration: completed ? TextDecoration.lineThrough : null,
          color: completed ? Colors.grey : Colors.black87,
        ),
      ),

      // 中间副标题：日期
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          date,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),

      // 右侧放置：操作按钮区域
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // 核心：必须限制 Row 只占用内部图标的大小
        children: [
          IconButton(
            constraints: const BoxConstraints(), // 紧凑型按钮，减小默认的 48 像素大外边距
            padding: const EdgeInsets.all(8),
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.blueGrey, size: 20),
          ),
          IconButton(
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(8),
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
          ),
        ],
      ),
    ),
  );
}
