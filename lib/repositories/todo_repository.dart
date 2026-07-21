// import '../services/api_service.dart';
// import '../models/todo.dart';

// class TodoRepository {
//   final ApiService apiService;

//   TodoRepository(this.apiService);

//   Future<List<Todo>> fetchTodos() async {
//     final response = await apiService.getTodos();

//     final data = response.data;

//     return data.map<Todo>((json) => Todo.fromJson(json)).toList();
//   }
// }
