import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MedicineDataBase {
  // Singleton instance
  static final MedicineDataBase instance = MedicineDataBase._init();

  // Database reference
  static Database? _database;

  // Private constructor
  MedicineDataBase._init();

  // Getter for database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medicine.db');
    return _database!;
  }

  // Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Create database tables
  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE medicines (
    id INTEGER NOT NULL,
    medicine_name TEXT NOT NULL,
    dose INTEGER NOT NULL,
    image_path TEXT NOT NULL,
    frequency TEXT NOT NULL,
    period INTEGER NOT NULL,
    taken INTEGER NOT NULL,
    next_date TEXT NOT NULL
  )
''');
  }

  // Close the database (good practice to have this)
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
