import 'dart:developer';

import 'package:cure/buisness/medicine/medicine.dart';
import 'package:cure/database/medicine_database.dart';
import 'package:sqflite/sqflite.dart';

class MedicineDao {
  final MedicineDataBase _database;

  MedicineDao(this._database);

  // Insert a new medicine
  Future<int> insertMedicine(Medicine medicine) async {
    final db = await _database.database;
    return await db.insert(
      'medicines',
      medicine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> createTable() async {
    final db = await _database.database;
    await db.execute('''
  CREATE TABLE medicines (
    id INTEGER NOT NULL,
    medicine_name TEXT NOT NULL,
    dose DECIMAL NOT NULL,
    image_path TEXT NOT NULL,
    frequency TEXT NOT NULL,
    period INTEGER NOT NULL,  
    taken INTEGER NOT NULL,
    next_date TEXT NOT NULL
  )
''');
    log('Table medicines created successfully!');
  }

  Future<void> dropMedicineTable() async {
    final db = await _database.database;
    await db.execute('DROP TABLE IF EXISTS medicines');
    log('Table medicines dropped successfully!');
  }

  // Delete a medicine by ID
  Future<int> deleteMedicine(int id) async {
    log('Removing pill with ID: $id');

    final db = await _database.database;
    return await db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> printAllMedicineIds() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> medicines = await db.query('medicines');
    log('All IDs in DB: ${medicines.map((m) => m['id']).toList()}');
  }

  // Update an existing medicine
  Future<int> updateMedicine(Medicine medicine, int id) async {
    final db = await _database.database;
    return await db.update(
      'medicines',
      medicine.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all medicines
  Future<List<Medicine>> getAllMedicines() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('medicines');
    return List.generate(maps.length, (i) => Medicine.fromMap(maps[i]));
  }

  // Get a specific medicine by ID
  Future<Medicine?> getMedicineById(int id) async {
    final db = await _database.database;
    final maps = await db.query(
      'medicines',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty ? Medicine.fromMap(maps.first) : null;
  }

  // Get medicines that need to be taken at a specific time
  Future<List<Medicine>> getMedicinesByDate(DateTime date) async {
    final db = await _database.database;
    final maps = await db.query(
      'medicines',
      where: 'next_date = ?',
      whereArgs: [date],
    );
    return List.generate(maps.length, (i) => Medicine.fromMap(maps[i]));
  }
}
