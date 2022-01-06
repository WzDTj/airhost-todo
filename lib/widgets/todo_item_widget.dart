import 'package:flutter/material.dart';
import 'package:airhost_todo/models/todo_model.dart';

typedef OnUpdateCallback = void Function(TodoModel);
typedef OnDeleteCallback = void Function(TodoModel);
typedef OnToggleCallback = void Function(TodoModel);

class TodoItemWidget extends StatelessWidget {
  final TodoModel todo;
  final OnUpdateCallback? onUpdate;
  final OnDeleteCallback? onDelete;
  final OnToggleCallback? onToggle;

  const TodoItemWidget({
    Key? key,
    required this.todo,
    this.onUpdate,
    this.onDelete,
    this.onToggle,
  }) : super(key: key);

  void _onToggle(bool? isSelected) {
    onToggle?.call(todo);
  }

  void _onUpdate() {
    onUpdate?.call(todo);
  }

  void _onDelete() {
    onDelete?.call(todo);
  }

  Widget _buildTitleWidget() {
    return Text(todo.title ?? '');
  }

  Widget? _buildSubtitleWidget() {
    return todo.note == null ? null : Text(todo.note!);
  }

  Widget _buildLeadingWidget() {
    return Checkbox(
      value: todo.completedDate != null,
      onChanged: _onToggle,
    );
  }

  Widget _buildTrailingWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: _onUpdate,
        ),
        IconButton(
          icon: const Icon(Icons.delete_outlined),
          onPressed: _onDelete,
        ),
      ],
    );
  }

  Widget _buildItem() {
    return Card(
      child: ListTile(
        title: _buildTitleWidget(),
        subtitle: _buildSubtitleWidget(),
        leading: _buildLeadingWidget(),
        trailing: _buildTrailingWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildItem();
  }
}
