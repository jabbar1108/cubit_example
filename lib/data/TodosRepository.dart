import 'package:bloc_app/data/TodoProvider.dart';

import '../models/todo.dart';

class TodosRepository {
  final TodoProvider todoProvider = TodoProvider();
  late final List<Todo> todos;

  Future<List<Todo>> getTodosData() async {
    try {
      final List<dynamic> dataset = await todoProvider.readTodos();
      todos = dataset.map((item) => Todo.fromJson(item)).toList();
      return todos;
    } catch(error) {
      throw Exception(error);
    }
  }
}