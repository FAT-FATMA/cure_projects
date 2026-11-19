import 'package:cure/buisness/medicine/medicine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Medicine model', () {
    test('serializes and restores a medicine record', () {
      final scheduledTime = DateTime(2026, 11, 19, 9, 30);
      final medicine = Medicine(
        id: 7,
        medicineName: 'Vitamin C',
        dose: 1,
        frequency: 'Daily',
        period: 14,
        taken: 2,
        next_date: scheduledTime,
      );

      final restored = Medicine.fromMap(medicine.toMap());

      expect(restored.id, 7);
      expect(restored.medicineName, 'Vitamin C');
      expect(restored.dose, 1);
      expect(restored.frequency, 'Daily');
      expect(restored.period, 14);
      expect(restored.taken, 2);
      expect(restored.next_date, scheduledTime);
    });
  });
}
