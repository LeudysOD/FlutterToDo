import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/models/detail.dart';
import '../database/database.dart';


class DetailRepository{
  static Future<List<Detail>> getAllDetails() async {
  final db = await DatabaseHelper.initDb();
  final result = await db.query('taskDetails', orderBy: 'id');
  return List.generate(result.length,(i) {
    return Detail.fromJson(result[i]);
  });
}

static Future<Detail> getDetailById(int id) async {
  final db = await DatabaseHelper.initDb();
   var result = await db.query('taskDetails', where: "id = ?",whereArgs: [id], limit: 1 ,  orderBy: 'id');
  return Detail.fromJson(result[0]);
}

static Future<int> createDetail(Detail detail)async {
  final db = await DatabaseHelper.initDb();
  final id = await db.insert('taskDetails', detail.toMap(),
  conflictAlgorithm: ConflictAlgorithm.replace
  );
  return id;
}


static Future<int> updateDetail(
 int id,
 Detail detail
) async{
  final db = await DatabaseHelper.initDb();
  final result = db.update('taskDetails', detail.toMap(), where: "id = ?", whereArgs: [id]);
  return result;
}

static Future<void> deleteDetail(int id) async{
  final db = await DatabaseHelper.initDb();
  try
  {
    await db.delete('taskDetails',where: "id = ?", whereArgs: [id]);
  }
  catch(ex)
  {
    debugPrint("Something went wrong");
  }
}
static Future<void> deleteByTaskId(int id) async{
  final db = await DatabaseHelper.initDb();
  try
  {
    await db.delete('taskDetails',where: "taskHeaderId = ?", whereArgs: [id]);
  }
  catch(ex)
  {
    debugPrint("Something went wrong");
  }
}
}