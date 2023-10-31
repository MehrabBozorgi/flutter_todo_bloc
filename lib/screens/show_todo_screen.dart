import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/logic/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/screens/add_screen.dart';

class ShowTodoScreen extends StatefulWidget {
  const ShowTodoScreen({super.key});

  @override
  State<ShowTodoScreen> createState() => _ShowTodoScreenState();
}

class _ShowTodoScreenState extends State<ShowTodoScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodoBloc>(context).add(CallGetTodo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TodoErrorState) {
              return Center(child: Text(state.error));
            }
            if (state is TodoCompletedState) {
              return ListView.builder(
                itemCount: state.todoModel.data!.length,
                itemBuilder: (context, index) {
                  final helper = state.todoModel.data![index];
                  return Card(
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(CallChangeIsDone(
                              id: helper.id!, isDone: helper.isdone == '0' ? '1' : '0'));
                        },
                        icon: helper.isdone == '0'
                            ? Icon(Icons.check_box_outline_blank)
                            : Icon(
                                Icons.check_box,
                                color: Colors.green,
                              ),
                      ),
                      title: Text(
                        helper.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        helper.description!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
