import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  bool isDone = false;

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
      appBar: AppBar(),
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
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text('انجام نشده'),
                          value: false,
                          groupValue: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text('انجام شده'),
                          value: true,
                          groupValue: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 0.75, 45),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    child: const Text(
                      'ویرایش وظیفه',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
