import 'dart:developer';
import 'dart:io';

import 'package:facegraph_test/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Helper {
  String tableName = "notes";
  String columnId = "id";
  String columnTitle = "title";
  String columnDescription = "description";
  String columnDate = "date";
  String columnStatus = "status";
  String columnPicture = "picture";

  Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "notes.db");
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableName ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDescription text NOT NULL,
          $columnDate DATETIME DEFAULT CURRENT_TIMESTAMP,
          $columnStatus INT not null,
          $columnPicture BLOB not null)
          ''');
    });
  }

  Future<int> insertNote(Note note) async {
    int result = 0;
    final Database db = await initDb();

    result = await db.insert('$tableName', note.toMap());

    return result;
  }

  Future<List<Note>> retrieveNotes() async {
    final Database db = await initDb();
    final List<Map<String, Object>> queryResult = await db.query('$tableName');
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await initDb();
    return db.update('$tableName', note.toMap(),
        where: '$columnId = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await initDb();
    return db.delete(
      '$tableName',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
