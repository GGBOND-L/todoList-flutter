import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/form_label.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  // 用户名
  final usernameController = TextEditingController();

  // 邮箱
  final emailController = TextEditingController();

  // 密码
  final passwordController = TextEditingController();

  // 确认密码
  final confirmPasswordController = TextEditingController();

  // 密码是否可见
  bool isPasswordVisible = false;

  // 确认密码是否可见
  bool isConfirmPasswordVisible = false;

  void handleRegister() {
    debugPrint('用户名: ${usernameController.text}');
    debugPrint('邮箱: ${emailController.text}');
    debugPrint('密码: ${passwordController.text}');
    debugPrint('确认密码: ${confirmPasswordController.text}');
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              const Text(
                '创建账号',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                '填写以下信息创建你的新账号',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),

              const SizedBox(height: 34),

              const FormLabel(text: '用户名'),

              const SizedBox(height: 8),

              CustomInput(
                controller: usernameController,
                hintText: '请输入用户名',
                icon: Icons.person,
              ),

              const SizedBox(height: 24),

              const FormLabel(text: '邮箱'),

              const SizedBox(height: 8),

              CustomInput(
                controller: emailController,
                hintText: '请输入邮箱',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              const FormLabel(text: '密码'),

              const SizedBox(height: 8),

              CustomInput(
                controller: passwordController,
                hintText: '请输入密码',
                icon: Icons.lock,
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xFF6B7280),
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 24),

              const FormLabel(text: '确认密码'),

              const SizedBox(height: 8),

              CustomInput(
                controller: confirmPasswordController,
                hintText: '请再次输入密码',
                icon: Icons.lock,
                obscureText: !isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF6B7280),
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 34),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: handleRegister,
                  child: const Text('创建账号'),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Text('已有账号?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                    ),
                    child: const Text('去登录'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
