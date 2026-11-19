import 'package:cure/buisness/medicine/medicine.dart';
import 'package:cure/buisness/medicine/medicine_notifier.dart';
import 'package:cure/screens/add_pill.dart';
import 'package:cure/widgets/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicinesScreen extends StatelessWidget {
  const MedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set scaffold background to white
      body: Consumer(
        builder: (context, ref, child) {
          List<Medicine> medicines = ref.watch(pillProvider);

          final notifier = ref.read(pillProvider.notifier);
          // bool isAll = true;
          return medicines.isEmpty
              ? Container(
                color: Colors.white, // Ensure empty state container is white
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'lib/assets/no_medicine.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Hoorraay there is no medicine',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )
              : Container(
                color: Colors.white, // Set ListView container background
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: medicines.length,
                        itemBuilder: (context, index) {
                          final medicine = medicines[index];
                          return MedicineCard(
                            id: index,
                            key: ValueKey(medicine.id),
                            medicineName: medicine.medicineName,
                            time: TimeOfDay(
                              hour: medicine.next_date!.hour,
                              minute: medicine.next_date!.minute,
                            ).format(context),
                            medicineImage: medicine.imagePath,
                            dose: medicine.dose,
                            onCheckDone: () async {
                              
                              if ((medicine.next_date!.year ==
                                      DateTime.now().year &&
                                  medicine.next_date!.month ==
                                      DateTime.now().month &&
                                  medicine.next_date!.day ==
                                      DateTime.now().day)) {
                                await showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: const Text('Check Medicine'),
                                        content: const Text(
                                          'Are you sure you want to check this medicine?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              
                                              notifier.updatePill(
                                                Medicine(
                                                  id: medicine.id,
                                                  medicineName:
                                                      medicine.medicineName,
                                                  dose: medicine.dose,
                                                  frequency: medicine.frequency,
                                                  period: medicine.period,
                                                  taken: medicine.taken + 1,
                                                  next_date: switch (medicine
                                                      .frequency) {
                                                    'Daily' => DateTime(
                                                      medicine.next_date!.year,
                                                      medicine.next_date!.month,
                                                      medicine.next_date!.day +
                                                          1,
                                                      medicine.next_date!.hour,
                                                      medicine
                                                          .next_date!
                                                          .minute,
                                                    ),
                                                    'Weekly' => DateTime(
                                                      medicine.next_date!.year,
                                                      medicine.next_date!.month,
                                                      medicine.next_date!.day +
                                                          7,
                                                      medicine.next_date!.hour,
                                                      medicine
                                                          .next_date!
                                                          .minute,
                                                    ),
                                                    'Monthly' => DateTime(
                                                      medicine.next_date!.year,
                                                      medicine
                                                              .next_date!
                                                              .month +
                                                          1,
                                                      medicine.next_date!.day,
                                                      medicine.next_date!.hour,
                                                      medicine
                                                          .next_date!
                                                          .minute,
                                                    ),
                                                    _ => medicine.next_date,
                                                  },
                                                  imagePath: medicine.imagePath,
                                                ),
                                              );

                                              Navigator.pop(context);
                                              if(medicine.taken/medicine.period >= 1){
                                                
                                                notifier.removePill(
                                                  medicine.id,
                                                );
                                              
                                              } else{
                                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Medicine checked successfully',
                                    ),
                                  ),
                                );
                                              }
                                            },
                                            child: const Text('Check Done'),
                                          ),
                                        ],
                                      ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'You can only check today\'s medicine',
                                    ),
                                  ),
                                );
                              }
                            },
                            onDelete: () async {
                              await showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text('Delete Medicine'),
                                      content: const Text(
                                        'Are you sure you want to delete this medicine?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            notifier.removePill(
                                              medicines[index].id,
                                            );
                                            // if (notifier.removePill(medicines[index].id!,) ==
                                            //     1) {
                                            //   ScaffoldMessenger.of(
                                            //     context,
                                            //   ).showSnackBar(
                                            //     const SnackBar(
                                            //       content: Text(
                                            //         'Medicine deleted successfully',
                                            //       ),
                                            //     ),
                                            //   );
                                            // } else {
                                            //   ScaffoldMessenger.of(
                                            //     context,
                                            //   ).showSnackBar(
                                            //     const SnackBar(
                                            //       content: Text(
                                            //         'Failed to delete medicine',
                                            //       ),
                                            //     ),
                                            //   );
                                            // }
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            period: medicine.period,
                            taken: medicine.taken,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white, // Keep FAB white
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPill()),
          );
        },
        tooltip: 'Add Medicine',
        child: Image.asset(
          'lib/assets/icons/add_pill.png',
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
