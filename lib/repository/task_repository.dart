import 'package:flutter/foundation.dart';
import 'package:sqflite/sql.dart';
import 'package:to_do_app/models/task.dart';
import '../../database/database.dart';

class TaskRespository {
static Future<List<Task>> getAllTask() async {
  final db = await DatabaseHelper.initDb();
  final result = await db.query('task', orderBy: 'id');
  return List.generate(result.length,(i) {
    return Task.fromJson(result[i]);
  });
}

static Future<List<Map<String,dynamic>>> getTaskById(int id) async {
  final db = await DatabaseHelper.initDb();
  return db.query('task', where: "id = ?",whereArgs: [id], limit: 1 ,  orderBy: 'id');
}

static Future<int> createItem(Task task)async {
  final db = await DatabaseHelper.initDb();
  final id = await db.insert('task', task.toMap(),
  conflictAlgorithm: ConflictAlgorithm.replace
  );

  return id;
}


static Future<int> updateItem( int id,Task task) async{
  final db = await DatabaseHelper.initDb();

  final result = db.update('task', task.toMap(), where: "id = ?", whereArgs: [id]);
  return result;
}

static Future<void> deleteItem(int id) async{
  final db = await DatabaseHelper.initDb();
  try
  {
    await db.delete('task',where: "id = ?", whereArgs: [id]);
  }
  catch(ex)
  {
    debugPrint("Something went wrong");
  }
}

}