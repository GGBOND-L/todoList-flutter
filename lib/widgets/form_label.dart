import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF111827),
        ),
        children: [
          // const Text('1233')  为什么不能这样写，提示Text类型不能给InlineSpan 类型
          // 为什么这个TextSpan是InlineSpan 类型，Text是Text类型
          TextSpan(
            text: ' *1',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }
}
