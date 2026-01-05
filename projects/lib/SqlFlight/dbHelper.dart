import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbHelper {
  static final dbHelper instance = dbHelper._init();
  static Database? _database;

  dbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('comments.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE comments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        comment TEXT NOT NULL
      )
    ''');
  }

  /// INSERT Record
  Future<int> insertComment(Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.insert('comments', data);
  }

  /// READ All Records
  Future<List<Map<String, dynamic>>> getComments() async {
    final db = await instance.database;
    return await db.query('comments', orderBy: "id DESC");
  }

  /// DELETE Record
  Future<int> deleteComment(int id) async {
    final db = await instance.database;
    return await db.delete('comments', where: 'id = ?', whereArgs: [id]);
  }

  /// UPDATE Record
  Future<int> updateComment(int id, Map<String, dynamic> data) async {
    final db = await instance.database;
    return await db.update(
      'comments',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
