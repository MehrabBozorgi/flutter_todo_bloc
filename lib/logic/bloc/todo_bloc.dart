import 'package:bloc/bloc.dart';
import 'package:flutter_todo_bloc/model/todo_model.dart';
import 'package:meta/meta.dart';

import '../../services/api_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ApiServices apiServices;

  TodoModel todoModel = TodoModel();

  TodoBloc(this.apiServices) : super(TodoInitial()) {
    on<CallGetTodo>((event, emit) async {
      emit(TodoLoadingState());

      try {
        todoModel = await apiServices.callGetTodo();

        emit(TodoCompletedState(todoModel));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });

    on<CallAddTodo>((event, emit) async {
      emit(TodoLoadingState());

      try {
        await apiServices.callAddTodo(event.title, event.description, event.isDone);
        // todoModel.data.add(Data())



        emit(TodoCompletedState(todoModel));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });

    on<CallChangeIsDone>((event, emit) async {
      emit(TodoLoadingState());

      try {
        await apiServices.callChangeIsDone(event.id,event.isDone);

        Data data=todoModel.data!.firstWhere((element) => element.id==event.id);

        data.isdone=event.isDone;



        emit(TodoCompletedState(todoModel));
      } catch (e) {
        emit(TodoErrorState(e.toString()));
      }
    });
  }
}
