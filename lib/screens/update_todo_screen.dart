import 'package:flutter/material.dart';
import 'package:airhost_todo/common/utility.dart';
import 'package:airhost_todo/models/todo_model.dart';
import 'package:airhost_todo/widgets/todo_form_widget.dart';
import 'package:airhost_todo/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class UpdateTodoScreen extends StatefulWidget {
  const UpdateTodoScreen({Key? key}) : super(key: key);

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  late TodoModel todo;

  void _onSaved(TodoModel newTodo) {
    var todoList = context.read<TodoProvider>();

    todoList.update(todo, newTodo);

    Navigator.pop(context);

    Utility.showSnackBar(context, content: 'Updated');
  }

  @override
  Widget build(BuildContext context) {
    todo = ModalRoute.of(context)!.settings.arguments as TodoModel;

    return Scaffold(
      appBar: AppBar(title: const Text("Todo Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TodoFormWidget(onSaved: _onSaved, todo: todo),
      ),
    );
  }
}
