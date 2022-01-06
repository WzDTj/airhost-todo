import 'package:airhost_todo/models/todo_model.dart';
import 'package:airhost_todo/services/database_service.dart';
import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _list = [];

  List<TodoModel> get uncompletedList {
    return _list.where((todo) => todo.completedDate == null).toList();
  }

  List<TodoModel> get completedList {
    return _list.where((todo) => todo.completedDate != null).toList();
  }

  void query() {
    DatabaseService.query('todos').then((rawResults) {
      _list = rawResults.map((rawResult) {
        return TodoModel.fromMap(rawResult);
      }).toList();

      notifyListeners();
    });
  }

  void add(TodoModel todo) {
    DatabaseService.insert('todos', todo).then((_) {
      _list.add(todo);
      notifyListeners();
    });
  }

  void update(TodoModel todo, TodoModel newTodo) {
    todo.title = newTodo.title;
    todo.note = newTodo.note;

    DatabaseService.update('todos', todo).then((_) => notifyListeners());
  }

  void delete(TodoModel todo) {
    DatabaseService.delete('todos', todo).then((_) {
      _list.remove(todo);
      notifyListeners();
    });
  }

  void toggle(TodoModel todo) {
    todo.completedDate = todo.completedDate == null
        ? DateTime.now().millisecondsSinceEpoch
        : null;

    DatabaseService.update('todos', todo).then((_) => notifyListeners());

    notifyListeners();
  }
}
