import 'dart:io';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  late Database database;
  static final DbHelper dbHelper = DbHelper._internal();

  DbHelper._internal();

  final String tableName = 'my_memories';
  final String idColumn = 'id';
  final String titleColumn = 'title';
  final String fromDateColumn = 'fromDate';
  final String toDateColumn = 'toDate';
  final String keywordsColumn = 'keywords';
  final String detailsColumn = 'details';

  Future<void> initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/mymemories.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $idColumn TEXT PRIMARY KEY,
            $titleColumn TEXT,
            $fromDateColumn TEXT,
            $toDateColumn TEXT,
            $keywordsColumn TEXT,
            $detailsColumn TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $idColumn TEXT PRIMARY KEY,
            $titleColumn TEXT,
            $fromDateColumn TEXT,
            $toDateColumn TEXT,
            $keywordsColumn TEXT,
            $detailsColumn TEXT
          )
        ''');
      },
      onDowngrade: (db, oldVersion, newVersion) async {
        await db.delete(tableName);
      },
    );
  }

  Future<List<FormModel>> getAllMemories() async {
    final List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => FormModel.fromJson(e)).toList();
  }

  Future<void> insertNewMemory(FormModel formModel) async {
    await database.insert(tableName, formModel.toJson());
  }

  Future<void> deleteMemory(FormModel formModel) async {
    await database.delete(tableName, where: '$idColumn = ?', whereArgs: [formModel.id]);
  }

  Future<void> deleteAllMemories() async {
    await database.delete(tableName);
  }

  Future<void> updateMemory(FormModel formModel) async {
    await database.update(
      tableName,
      formModel.toJson(),
      where: '$idColumn = ?',
      whereArgs: [formModel.id],
    );
  }
}
