import 'package:airhost_todo/interfaces/mapable_interface.dart';

class TodoModel extends MapableInterface {
  int id;
  String? title;
  String? note;
  int? completedDate;

  TodoModel({
    required this.id,
    this.title,
    this.note,
    this.completedDate,
  });

  TodoModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        title = map['title'] as String?,
        note = map['note'] as String?,
        completedDate = map['completed_at'] as int?,
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'completed_at': completedDate,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, note: $note, completed_at: $completedDate}';
  }
}
