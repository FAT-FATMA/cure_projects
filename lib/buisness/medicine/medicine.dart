
class Medicine {
  String medicineName, imagePath, frequency;
  int period, id, taken, dose;
  DateTime? next_date;
  Medicine({
    required this.id,
    required this.medicineName,
    required this.period,
    required this.taken,
    required this.frequency,
    required this.dose,
    required this.next_date,
    this.imagePath = 'lib/assets/default_pill.png',
  });
  Map<String, dynamic> toMap() {
    return {
      'medicine_name': medicineName,
      'dose': dose,
      'frequency': frequency,
      'image_path': imagePath,
      'period': period,
      'taken': taken,
      'id': id,
      'next_date': next_date?.toIso8601String(),
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] as int,
      taken: map['taken'],
      medicineName: map['medicine_name'],
      imagePath: map['image_path'] ?? 'lib/assets/default_pill.png',
      dose: map['dose'],
      frequency: map['frequency'],
      period: map['period'],
      next_date: DateTime.parse(map['next_date']),
    );
  }
}
