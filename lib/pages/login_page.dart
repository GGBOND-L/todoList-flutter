import 'package:flutter/material.dart';
import 'register_page.dart';

import '../widgets/custom_input.dart';
import '../widgets/form_label.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// 登录页面状态
class _LoginPageState extends State<LoginPage> {
  /// 邮箱输入框控制器
  final TextEditingController emailController = TextEditingController();

  /// 密码输入框控制器
  final TextEditingController passwordController = TextEditingController();

  /// 密码是否隐藏
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// 点击登录
  void handleLogin() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    debugPrint('邮箱: $email');
    debugPrint('密码: $password');

    // 跳转到工作台
    Navigator.pushReplacementNamed(context, '/workbench');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 96),

                  const Text(
                    '欢迎回来',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    '登录后管理你的待办事项',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),

                  const SizedBox(height: 34),

                  const FormLabel(text: '邮箱'),

                  const SizedBox(height: 10),

                  CustomInput(
                    controller: emailController,
                    hintText: '请输入邮箱',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 22),

                  const FormLabel(text: '密码'),

                  const SizedBox(height: 10),

                  CustomInput(
                    controller: passwordController,
                    hintText: '请输入密码',
                    icon: Icons.lock_outline,
                    obscureText: obscurePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFF9CA3AF),
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1677FF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '登录666',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    children: [
                      const Text(
                        '没有账号？',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint('点击注册');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          ' 注册666',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1677FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
