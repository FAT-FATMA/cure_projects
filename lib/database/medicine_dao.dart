import 'dart:developer';

import 'package:cure/buisness/medicine/medicine.dart';
import 'package:cure/database/medicine_database.dart';

class MedicineDao {
  final MedicineDataBase _database;

  MedicineDao(this._database);

  Future<int> insertMedicine(Medicine medicine) async {
    final db = await _database.database;
    return db.insert('medicines', medicine.toMap());
  }

  Future<void> clearAllMedicines() async {
    final db = await _database.database;
    await db.delete('medicines');
    log('All medicine records cleared.');
  }

  Future<int> deleteMedicine(int id) async {
    final db = await _database.database;
    return db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateMedicine(Medicine medicine, int id) async {
    final db = await _database.database;
    return db.update(
      'medicines',
      medicine.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Medicine>> getAllMedicines() async {
    final db = await _database.database;
    final maps = await db.query('medicines');
    return maps.map(Medicine.fromMap).toList();
  }

  Future<Medicine?> getMedicineById(int id) async {
    final db = await _database.database;
    final maps = await db.query(
      'medicines',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return maps.isEmpty ? null : Medicine.fromMap(maps.first);
  }

  Future<List<Medicine>> getMedicinesByDate(DateTime date) async {
    final db = await _database.database;
    final maps = await db.query(
      'medicines',
      where: 'next_date = ?',
      whereArgs: [date.toIso8601String()],
    );

    return maps.map(Medicine.fromMap).toList();
  }

  Future<void> printAllMedicineIds() async {
    final db = await _database.database;
    final medicines = await db.query('medicines');
    log('All IDs in DB: ${medicines.map((medicine) => medicine['id']).toList()}');
  }
}
