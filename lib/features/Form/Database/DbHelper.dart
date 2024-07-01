import 'package:image_picker/image_picker.dart';
import 'package:mymemories/features/Form/models/FormModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  late Database database;
  static final DbHelper dbHelper = DbHelper._internal();
  final String tableName = 'my_memories';
  final String idColumn = 'id';
  final String titleColumn = 'title';
  final String fromDateColumn = 'fromDate';
  final String toDateColumn = 'toDate';
  final String keywordsColumn = 'keywords';
  final String detailsColumn = 'details';
  final String imagesColumn = 'images'; 

  DbHelper._internal();

  factory DbHelper() {
    return dbHelper;
  }

  Future<void> initDb() async {
    String path = join(await getDatabasesPath(), 'memories.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName('
          '$idColumn TEXT PRIMARY KEY, '
          '$titleColumn TEXT, '
          '$fromDateColumn TEXT, '
          '$toDateColumn TEXT, '
          '$keywordsColumn TEXT, '
          '$detailsColumn TEXT, '
          '$imagesColumn TEXT'
          ')',
        );
      },
    );
  }

  Future<int> insertMemory(FormModel memory) async {
    return await database.insert(
      tableName,
      memory.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FormModel>> getMemories() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);

    return List.generate(maps.length, (i) {
      return FormModel.fromJson(maps[i]);
    });
  }

  Future<int> updateMemory(FormModel memory) async {
    return await database.update(
      tableName,
      memory.toJson(),
      where: '$idColumn = ?',
      whereArgs: [memory.id],
    );
  }

  Future<void> deleteMemory(String id) async {
    await database.delete(
      tableName,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }
}
