import 'package:airhost_todo/models/todo_model.dart';
import 'package:flutter/material.dart';

typedef OnSavedCallback = void Function(TodoModel);

class TodoFormWidget extends StatefulWidget {
  final TodoModel? todo;
  final OnSavedCallback? onSaved;

  const TodoFormWidget({Key? key, this.todo, this.onSaved}) : super(key: key);

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? title;
  String? note;

  @override
  Widget build(BuildContext context) {
    var todo = widget.todo;

    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: todo?.title,
            decoration: const InputDecoration(labelText: "Title"),
            validator: (value) =>
                value == null ? 'Please enter the title' : null,
            onSaved: (value) => title = value,
          ),
          TextFormField(
            initialValue: todo?.note,
            decoration: const InputDecoration(labelText: "Note"),
            onSaved: (value) => note = value,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  var validated = _key.currentState!.validate();
                  if (validated) {
                    _key.currentState!.save();

                    var id = DateTime.now().millisecondsSinceEpoch;

                    var todo = TodoModel(id: id, title: title, note: note);

                    widget.onSaved?.call(todo);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
