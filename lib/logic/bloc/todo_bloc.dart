import 'package:bloc/bloc.dart';
import 'package:flutter_todo_bloc/model/todo_model.dart';
import 'package:meta/meta.dart';

import '../../services/api_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiServices;

  TodoBloc(this.apiServices) : super(TodoInitial()) {
    on<CallGetTodo>((event, emit) async {
      emit(TodoLoadingState());

      try {
        final TodoModel todoModel = await apiServices.callGetTodo();

        emit(TodoCompletedState(todoModel));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });
  }
}
