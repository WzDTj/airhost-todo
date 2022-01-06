import 'package:flutter/material.dart';
import 'package:airhost_todo/common/utility.dart';
import 'package:airhost_todo/models/todo_model.dart';
import 'package:airhost_todo/widgets/todo_form_widget.dart';
import 'package:airhost_todo/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  void _onSaved(TodoModel todo) {
    var todoList = context.read<TodoProvider>();

    todoList.add(todo);

    Navigator.pop(context);

    Utility.showSnackBar(context, content: 'Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Todo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TodoFormWidget(onSaved: _onSaved),
      ),
    );
  }
}
