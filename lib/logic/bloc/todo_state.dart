part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState{}

class TodoCompletedState extends TodoState{

  final TodoModel todoModel;

  TodoCompletedState(this.todoModel);

}

class TodoErrorState extends TodoState{
  final String error;

  TodoErrorState(this.error);
}
