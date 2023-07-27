import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoProvider {
  Future<List<dynamic>> readTodos() async {
    const url = "https://jsonplaceholder.typicode.com/todos";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception("Could not get todos");
    }
  }
}