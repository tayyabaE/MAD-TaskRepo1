import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projects/FinalsPrep/SQFLite/model/Car.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _db;
  DbHelper._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb("car.db");
    return _db!;
  }

  Future<Database> _initDb(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async {
    final String sql = '''
    CREATE TABLE cars(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      make TEXT,
      model TEXT
    )
    ''';
    await db.execute(sql);
  }

  Future<List<Car>> getAll() async {
    final db = await instance.database;

    List<Map<String, dynamic>> result = await db.query('cars');
    return result.map((c) => Car.fromMap(c)).toList();
  }

  Future<int> insertCar(Car car) async {
    final db = await instance.database;

    if (car.name.isEmpty || car.make.isEmpty || car.model.isEmpty) {
      return 0;
    }

    return db.insert(
      "cars",
      car.toMap(),
    );
  }

  Future<int> updateCar(int id, Car car) async {
    final db = await instance.database;

    if (car.name.isEmpty || car.make.isEmpty || car.model.isEmpty)
      return 0;

    return db.update(
      "cars",
      car.toMap(),
      where: "id = ?",
      whereArgs: [id]
    );
    return 0;
  }

  Future<int> deleteCar(int id) async {
    final db = await instance.database;

    return db.delete(
      "cars",
      where: "id = ?",
      whereArgs: [id]
    );
  }
}
