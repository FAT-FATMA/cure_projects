import 'package:cure/buisness/medicine/medicine_notifier.dart';
import 'package:cure/widgets/hospitalcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class StatusScreen extends ConsumerStatefulWidget {
  const StatusScreen({super.key});

  final String title = 'Cure';

  @override
  ConsumerState<StatusScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<StatusScreen> {
  String remainingTime = '';
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    countdownTimer?.cancel(); // Cancel any existing timer

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final nextMedicine = ref.read(nextClosestMedicineProvider);
      if (nextMedicine == null || nextMedicine.next_date == null) {
        setState(() {
          remainingTime = 'No Medicine';
        });
        return;
      }

      final nextDoseDateTime = DateTime(
        nextMedicine.next_date!.year,
        nextMedicine.next_date!.month,
        nextMedicine.next_date!.day,
        nextMedicine.next_date!.hour,
        nextMedicine.next_date!.minute,
      );

      final now = DateTime.now();
      final difference = nextDoseDateTime.difference(now);

      if (difference.isNegative) {
        nextMedicine.next_date = switch (nextMedicine.frequency) {
          'Daily' => DateTime(
            nextMedicine.next_date!.year,
            nextMedicine.next_date!.month,
            nextMedicine.next_date!.day + 1,
            nextMedicine.next_date!.hour,
            nextMedicine.next_date!.minute,
          ),
          'Weekly' => DateTime(
            nextMedicine.next_date!.year,
            nextMedicine.next_date!.month,
            nextMedicine.next_date!.day + 7,
            nextMedicine.next_date!.hour,
            nextMedicine.next_date!.minute,
          ),
          'Monthly' => DateTime(
            nextMedicine.next_date!.year,
            nextMedicine.next_date!.month + 1,
            nextMedicine.next_date!.day,
            nextMedicine.next_date!.hour,
            nextMedicine.next_date!.minute,
          ),
          _ => nextMedicine.next_date,
        };
        setState(() {
          remainingTime = '00:00:00';
        });
      } else {
        final totalSeconds = difference.inSeconds;
        final days = 0; // (totalSeconds ~/ 86400).toString().padLeft(2, '0');
        final hours = ((totalSeconds) ~/ 3600).toString().padLeft(2, '0');
        final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(
          2,
          '0',
        );
        final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
        setState(() {
          remainingTime = '$days:$hours:$minutes:$seconds';
          //log(DateTime.now().toString());
        });
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nextMedicine = ref.watch(nextClosestMedicineProvider);

    return Center(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('lib/assets/pill_pattern.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  // color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: const Text(
                        'Next Dose ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: const Text(
                        'after:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Center(
                    child: Text(
                      remainingTime.isNotEmpty ? remainingTime : 'Loading...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: const Text(
                              'Medicine:',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              nextMedicine?.medicineName ?? 'No Medicine',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            'Dose:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            nextMedicine?.dose != null
                                ? nextMedicine!.dose > 1
                                    ? '${nextMedicine.dose} Tablets'
                                    : '${nextMedicine.dose} Tablet'
                                : 'No Dose',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: const Text(
                  'Nearby Hospitals',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  label: const Text('View All'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 242, 242, 242),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                HospitalCard(
                  hospitalName: "Al Shorouk Hospital",
                  hospitalType: "General",
                  hospitalRating: '4.5',
                  hospitalCity: 'Cairo',
                  hospitalDistance: '3.2 km',
                  hospitalPhone: '+20 100 123 4567',
                  hospitalLocation: '90th St, Al Shorouk',
                ),
                HospitalCard(
                  hospitalName: "Dar El Fouad Hospital",
                  hospitalType: "Specialized",
                  hospitalRating: '4.8',
                  hospitalCity: 'October',
                  hospitalDistance: '12.5 km',
                  hospitalPhone: '+20 100 234 5678',
                  hospitalLocation: 'Central Axis Road',
                ),
                HospitalCard(
                  hospitalName: "Cairo Medical Center",
                  hospitalType: "Multi-Specialty",
                  hospitalRating: '4.6',
                  hospitalCity: 'Nasr City',
                  hospitalDistance: '5.1 km',
                  hospitalPhone: '+20 100 345 6789',
                  hospitalLocation: 'Makram Ebeid St',
                ),
                HospitalCard(
                  hospitalName: "Children's Cancer Hospital",
                  hospitalType: "Pediatric",
                  hospitalRating: '4.9',
                  hospitalCity: 'Giza',
                  hospitalDistance: '8.3 km',
                  hospitalPhone: '+20 100 456 7890',
                  hospitalLocation: 'El Dokki St',
                ),
                HospitalCard(
                  hospitalName: "Egyptian Cardiac Center",
                  hospitalType: "Cardiology",
                  hospitalRating: '4.7',
                  hospitalCity: 'Heliopolis',
                  hospitalDistance: '6.7 km',
                  hospitalPhone: '+20 100 567 8901',
                  hospitalLocation: 'El Merghany St',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
