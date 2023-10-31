import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/logic/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/logic/cubit/change_index_cubit.dart';
import 'package:flutter_todo_bloc/screens/show_todo_screen.dart';
import 'package:flutter_todo_bloc/snack_bar_widget.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ShowTodoScreen(),
            ),
          );
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'عنوان'),
                    controller: _titleController,
                    validator: validatorFunc('عنوان'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'توضیحات'),
                    controller: _descController,
                    validator: validatorFunc('توضیحات'),
                    textInputAction: TextInputAction.newline,
                    maxLines: 8,
                    minLines: 4,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ChangeIndexCubit, bool>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: const Text('انجام نشده'),
                              value: false,
                              groupValue: BlocProvider.of<ChangeIndexCubit>(context).isDone,
                              onChanged: (value) {
                                BlocProvider.of<ChangeIndexCubit>(context).changeIndex(value!);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text('انجام شده'),
                              value: true,
                              groupValue: BlocProvider.of<ChangeIndexCubit>(context).isDone,
                              onChanged: (value) {
                                BlocProvider.of<ChangeIndexCubit>(context).changeIndex(value!);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<TodoBloc, TodoState>(
                    listener: (context, state) {
                      if (state is TodoErrorState) {
                        getSnackBarWidget(context, state.error, Colors.red);
                      }
                      if (state is TodoCompletedState) {
                        getSnackBarWidget(context, 'وظیفه با موفقیت اضافه شد', Colors.green);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShowTodoScreen(),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {

                      if(state is TodoLoadingState){

                        return const Center(child: CircularProgressIndicator());

                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.75, 45),
                        ),
                        onPressed: () {

                          if (formKey.currentState!.validate()) {
                            context.read<TodoBloc>().add(
                                  CallAddTodo(
                                    title: _titleController.text,
                                    description: _descController.text,
                                    isDone: BlocProvider.of<ChangeIndexCubit>(context).isDone
                                        ? '1'
                                        : '0',
                                  ),
                                );
                          }
                        },
                        child: const Text(
                          'ثبت وظیفه',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validatorFunc(String label) {
    return (value) {
      if (value!.isEmpty) {
        return '$label نمیتواند خالی باشد';
      }
      if (value.length < 3) {
        return '$label نمیتواند کمتر از 3 کرکتر باشد';
      }
      return null;
    };
  }
}
