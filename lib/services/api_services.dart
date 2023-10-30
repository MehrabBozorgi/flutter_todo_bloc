import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/todo_model.dart';

class ApiServices {
  final Dio _dio = Dio();
  final String apiUrl = 'http://programmingshow.ir/todo';

  Future<TodoModel> callGetTodo() async {

    final Response response = await _dio.get('http://programmingshow.ir/todo/index/getTodo');

    
    final TodoModel todoModel = TodoModel.fromJson(jsonDecode(response.data));

    return todoModel;
  }
}
