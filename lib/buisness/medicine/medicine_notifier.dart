import 'package:cure/buisness/medicine/medicine.dart';
import 'package:cure/database/medicine_database.dart';
import 'package:cure/database/medicine_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final medicineDatabaseProvider = Provider<MedicineDataBase>((ref) {
  return MedicineDataBase.instance;
});

final medicineDaoProvider = Provider<MedicineDao>((ref) {
  return MedicineDao(ref.read(medicineDatabaseProvider));
});

final pillProvider =
    StateNotifierProvider<MedicineNotifierProvider, List<Medicine>>((ref) {
      final dao = ref.read(medicineDaoProvider);
      return MedicineNotifierProvider(dao).._loadMedicines();
    });

final nextClosestMedicineProvider = StateProvider<Medicine?>((ref) {
  final upcomingMedicines =
      ref
          .watch(pillProvider)
          .where((medicine) => medicine.next_date != null)
          .toList();

  if (upcomingMedicines.isEmpty) return null;

  upcomingMedicines.sort(
    (first, second) => first.next_date!.compareTo(second.next_date!),
  );

  return upcomingMedicines.first;
});

class MedicineNotifierProvider extends StateNotifier<List<Medicine>> {
  final MedicineDao _dao;

  MedicineNotifierProvider(this._dao) : super([]);

  Future<void> _loadMedicines() async {
    state = await _dao.getAllMedicines();
  }

  Future<void> clearAllMedicines() async {
    await _dao.clearAllMedicines();
    state = [];
  }

  Future<void> addPill(Medicine pill) async {
    await _dao.insertMedicine(pill);
    state = [...state, pill];
  }

  Future<int> removePill(int id) async {
    state = state.where((medicine) => medicine.id != id).toList();
    return _dao.deleteMedicine(id);
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
}
