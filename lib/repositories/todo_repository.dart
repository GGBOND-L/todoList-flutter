import '../models/todo.dart';
import '../services/api_service.dart';

class TodoRepository {
  final ApiService apiService;

  TodoRepository(this.apiService);

  Future<List<Todo>> fetchTodos() async {
    final response = await apiService.getTodos();

    final responseData = response.data;

    if (responseData['code'] != 0) {
      throw Exception(responseData['message']);
    }

    final List<dynamic> todoList = responseData['data'];

    return todoList.map((json) => Todo.fromJson(json)).toList();
  }
}
