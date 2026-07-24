class Todo {
  final int id;
  String title;
  bool isCompleted;
  final String createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });

  // factory这是什么写法？
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['completed'] == 1,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': isCompleted ? 1 : 0,
      'created_at': createdAt,
    };
  }
}
