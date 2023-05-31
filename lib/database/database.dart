import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

static Future<void> createTables(Database database) async {
await database.execute("""CREATE TABLE task(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
      )
      """);

      await database.execute("""CREATE TABLE taskDetails(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        taskHeaderId INT,
        description TEXT,
        initDate TEXT,
        initHour TEXT ,
        completed INT 
      )
      """);

      
}

static Future<Database> initDb () async {
final directory =  await getDatabasesPath();
 final path = join(directory,"taskmanager.db");  
 /*    databaseFactory.deleteDatabase(path); */
  return openDatabase(
    path,
    version: 1,
    onCreate: (Database database, int version) async{
      await createTables(database);
    }
  );
}



}