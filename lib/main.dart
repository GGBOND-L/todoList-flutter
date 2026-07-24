import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/workbench_page.dart';
// import './controllers/todo_controller.dart';
import 'package:provider/provider.dart';
import './controllers/todo_controller.dart';
import 'services/api_service.dart';
import 'repositories/todo_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),

        Provider(
          create: (context) {
            return TodoRepository(context.read<ApiService>());
          },
        ),

        ChangeNotifierProvider(
          create: (context) {
            return TodoController(context.read<TodoRepository>());
          },
        ),
      ],

      child: const TodoApp(),
    ),
  );
}

/// 应用入口组件
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Login',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/workbench': (context) => const WorkbenchPage(),
      },
    );
  }
}
