import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../screens/conversion.dart';
class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'conversions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE conversions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            consultationCode TEXT,
            realValue REAL,
            dollarValue REAL,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<void> createConversion(String consultationCode, double realValue,
      double dollarValue, String date) async {
    final db = await database;
    await db.insert('conversions', {
      'consultationCode': consultationCode,
      'realValue': realValue,
      'dollarValue': dollarValue,
      'date': date,
    });
  }

  Future<List<Conversion>> getConversions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('conversions');

    return List.generate(maps.length, (i) {
      return Conversion(
        id: maps[i]['id'],
        consultationCode: maps[i]['consultationCode'],
        realValue: maps[i]['realValue'],
        dollarValue: maps[i]['dollarValue'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> deleteConversion(int id) async {
    final db = await database;
    await db.delete('conversions', where: 'id = ?', whereArgs: [id]);
  }
}