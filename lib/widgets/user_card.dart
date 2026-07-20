import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String username;
  final String email;

  const UserCard({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
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
                children: [Text(username), Text(email)],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
