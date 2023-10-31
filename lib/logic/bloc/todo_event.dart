part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class CallGetTodo extends TodoEvent {}

class CallAddTodo extends TodoEvent {
  final String title;
  final String description;
  final String isDone;

  CallAddTodo({required this.title, required this.description, required this.isDone});
}


class CallChangeIsDone extends TodoEvent{

  final String id;
  final String isDone;

  CallChangeIsDone({required this.id, required this.isDone});

}