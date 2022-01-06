import 'package:flutter/material.dart';
import 'package:airhost_todo/common/utility.dart';
import 'package:airhost_todo/widgets/todo_list_widget.dart';
import 'package:airhost_todo/models/todo_model.dart';
import 'package:airhost_todo/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TodoProvider>().query();
  }

  void _onUpdate(TodoModel todo) {
    Navigator.pushNamed(context, '/update_todo', arguments: todo);
  }

  void _onToggle(TodoModel todo) {
    context.read<TodoProvider>().toggle(todo);
  }

  void _onDelete(TodoModel todo) {
    Utility.confirm(
      context,
      title: 'Confirmation',
      content: 'Do you want to delete this todo?',
      onCancel: () => Navigator.pop(context),
      onConfirm: () {
        context.read<TodoProvider>().delete(todo);
        Utility.showSnackBar(context, content: 'Deleted');
        Navigator.pop(context);
      },
    );
  }

  FloatingActionButton get _floatingActionButton {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/create_todo'),
      child: const Icon(Icons.add),
    );
  }

  TodoListWidget _buildTodoListWidget(List<TodoModel> list) {
    return TodoListWidget(
      list: list,
      onToggle: _onToggle,
      onUpdate: _onUpdate,
      onDelete: _onDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Air Host Todo"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Todo'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<TodoProvider>(
              builder: (context, provider, widget) {
                return _buildTodoListWidget(provider.uncompletedList);
              },
            ),
            Consumer<TodoProvider>(
              builder: (context, provider, widget) {
                return _buildTodoListWidget(provider.completedList);
              },
            ),
          ],
        ),
        floatingActionButton: _floatingActionButton,
      ),
    );
  }
}
