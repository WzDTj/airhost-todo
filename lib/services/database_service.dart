import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:airhost_todo/interfaces/mapable_interface.dart';

class DatabaseService {
  DatabaseService._();

  static late Future<Database> _database;

  static Future<void> initilize() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'airhost_todo.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, note TEXT, completed_at INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> query(String table) {
    return _database.then((db) {
      return db.query(table);
    });
  }

  static Future<int> insert(String table, MapableInterface model) {
    return _database.then((db) {
      return db.insert(
        table,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  static Future<int> update(String table, MapableInterface model) {
    var values = model.toMap();
    return _database.then((db) {
      return db.update(
        table,
        values,
        where: 'id = ?',
        whereArgs: [values['id']],
      );
    });
  }

  static Future<int> delete(String table, MapableInterface model) {
    var values = model.toMap();
    return _database.then((db) {
      return db.delete(
        table,
        where: 'id = ?',
        whereArgs: [values['id']],
      );
    });
  }
}
