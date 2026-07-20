import 'package:flutter/material.dart';

class TodoStatCard extends StatelessWidget {
  final int total;
  final String title;
  final Widget icon;

  const TodoStatCard({
    super.key,
    required this.total,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
            children: [Text('$total'), Text(title)],
          ),
        ],
      ),
    );
  }
}
