import 'dart:developer';

import 'package:cure/buisness/medicine/medicine.dart';
import 'package:cure/database/medicine_database.dart';
import 'package:cure/database/medicine_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create provider instances
final medicineDatabaseProvider = Provider<MedicineDataBase>((ref) {
  return MedicineDataBase.instance;
});

final medicineDaoProvider = Provider<MedicineDao>((ref) {
  final database = ref.read(medicineDatabaseProvider);
  return MedicineDao(database);
});

// Updated StateNotifier provider
final pillProvider =
    StateNotifierProvider<MedicineNotifierProvider, List<Medicine>>((ref) {
      final dao = ref.read(medicineDaoProvider);

      return MedicineNotifierProvider(dao).._loadMedicines();
    });

final nextClosestMedicineProvider = StateProvider<Medicine?>((ref) {
  final medicines = ref.watch(pillProvider);
  log("$medicines");
  if (medicines.isEmpty) return null;

  medicines.sort(
    (a, b) => DateTime(
      a.next_date!.year,
      a.next_date!.month,
      a.next_date!.day,
      a.next_date!.hour,
      a.next_date!.minute,
    ).compareTo(
      DateTime(
        b.next_date!.year,
        b.next_date!.month,
        b.next_date!.day,
        b.next_date!.hour,
        b.next_date!.minute,
      ),
    ),
  );

  return medicines.first;
});

class MedicineNotifierProvider extends StateNotifier<List<Medicine>> {
  final MedicineDao _dao;

  MedicineNotifierProvider(this._dao) : super([]);

  Future<void> _loadMedicines() async {
    final medicines = await _dao.getAllMedicines();
    state = medicines;
  }

  Future<void> clearAllMedicines() async {
    await _dao.dropMedicineTable();
    state = [];
  }

  Future<void> addPill(Medicine pill) async {
    await _dao.insertMedicine(pill);
    final newPill = pill;
    state = [...state, newPill];
  }

  Future<int> removePill(int id) async {
    // Update the state immediately so the UI reflects the change
    state = state.where((medicine) => medicine.id != id).toList();
    return await _dao.deleteMedicine(id);
  }

  Future<List<Medicine>> getTodayMedicine() async {
    final medicines = await _dao.getAllMedicines();
    final today = DateTime.now();
    return medicines.where((medicine) {
      final nextDate = medicine.next_date;
      return nextDate != null &&
          nextDate.year == today.year &&
          nextDate.month == today.month &&
          nextDate.day == today.day;
    }).toList();
  }

  Future<void> updatePill(Medicine updatedPill) async {
    await _dao.updateMedicine(updatedPill, updatedPill.id);
    state =
        state
            .map(
              (medicine) =>
                  medicine.id == updatedPill.id ? updatedPill : medicine,
            )
            .toList();
  }

  // Additional useful methods
  // Future<List<Medicine>> getMedicinesByTime(String time) async {
  //   return await _dao.getMedicinesByTime(time);
  // }

  // Future<Medicine?> getMedicineById(int id) async {
  //   return await _dao.getMedicineById(id);
  // }
}
