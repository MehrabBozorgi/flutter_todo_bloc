import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/logic/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/logic/cubit/change_index_cubit.dart';
import 'package:flutter_todo_bloc/screens/show_todo_screen.dart';
import 'package:flutter_todo_bloc/services/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeIndexCubit()),
        BlocProvider(create: (context) => TodoBloc(ApiServices())),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: ShowTodoScreen(),
        ),
      ),
    );
  }
}
