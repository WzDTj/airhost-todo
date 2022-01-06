import 'package:flutter/material.dart';
import 'package:airhost_todo/models/todo_model.dart';
import 'package:airhost_todo/widgets/todo_item_widget.dart';

typedef OnUpdateCallback = void Function(TodoModel);
typedef OnDeleteCallback = void Function(TodoModel);
typedef OnToggleCallback = void Function(TodoModel);

class TodoListWidget extends StatefulWidget {
  final List<TodoModel> list;
  final OnUpdateCallback? onUpdate;
  final OnDeleteCallback? onDelete;
  final OnToggleCallback? onToggle;

  const TodoListWidget({
    Key? key,
    required this.list,
    this.onUpdate,
    this.onDelete,
    this.onToggle,
  }) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  Widget _itemBuilder(BuildContext context, int index) {
    return TodoItemWidget(
      todo: widget.list[index],
      onToggle: widget.onToggle,
      onUpdate: widget.onUpdate,
      onDelete: widget.onDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: widget.list.length,
      itemBuilder: _itemBuilder,
    );
  }
}
