import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:complete_example/SQF_Lite/model/user.dart';

class DbHelper{
  static final DbHelper instance = DbHelper._init();
  static Database? _db;
  DbHelper._init();

  Future<Database> get database async{
    if(_db != null) return _db!;
    _db = await _initDb("user.db");
    return _db!;
  }

  Future<Database> _initDb(String filepath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async{
    final String sql = '''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      role TEXT
    )
    ''';
    await db.execute(sql);
  }

  Future<List<User>> getAll() async{
    final db = await instance.database;

    List<Map<String, dynamic>> result = await db.query('users');
    return result.map((u) => User.fromMap(u)).toList();
  }

  Future<int> addUser(User user) async{
    final db = await instance.database;

    if(user.name.isEmpty || user.role.isEmpty){
      return 0;
    }
    return db.insert("users", user.toMap(),);
  }

  Future<int> updateUser(int id, User user) async{
    final db = await instance.database;

    if (user.name.isEmpty || user.role.isEmpty){
      return 0;
    }
    return db.update(
      "users",
      user.toMap(),
      where: "id = ?",
      whereArgs: [id]
    );
    return 0;
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return db.delete(
      "users",
      where: "id = ?",
      whereArgs: [id],
    );
  }

}