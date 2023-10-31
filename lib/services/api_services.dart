import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/todo_model.dart';

class ApiServices {
  final Dio _dio = Dio();
  final String apiUrl = 'http://programmingshow.ir/todo';

  Future<TodoModel> callGetTodo() async {
    final Response response = await _dio.get('$apiUrl/index/getTodo');

    final TodoModel todoModel = TodoModel.fromJson(jsonDecode(response.data));

    return todoModel;
  }

  Future<void> callAddTodo(String title, String description, String isDone) async {
    await _dio.get('$apiUrl/index/todo?title=$title&description=$description&isdone=$isDone');
  }

  Future<void> callChangeIsDone(String id, String isDone) async {
    await _dio.get('$apiUrl/index/changeDone?id=$id&isdone=$isDone');
  }
}
