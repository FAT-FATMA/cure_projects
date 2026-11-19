
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MedicineCard extends StatefulWidget {
  MedicineCard({
    super.key,
    required this.medicineName,
    required this.time,
    this.medicineImage = 'lib/assets/default_pill.png',
    required this.dose,
    required this.period,
    required this.id,
    required this.onDelete,
    required this.onCheckDone,
    required this.taken,

  });
  final Function onDelete;
  VoidCallback? onCheckDone;
  String medicineName;
  String time;
  String medicineImage;
  int dose,taken,id,period;
 
  

  @override
  State<StatefulWidget> createState() => _MedicineCard();
}

class _MedicineCard extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onLongPress: () {
        widget.onDelete();
      },
      child: 
    Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 163,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 207, 224, 251),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.medicineImage,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.medicineName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(child: Text('Time: ${widget.time}')),
                  Container(
                    child: Text(
                      widget.dose > 1
                          ? 'Dose: ${widget.dose} tablet'
                          : 'Dose: ${widget.dose} tablets',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onCheckDone,
                    icon: Icon(Icons.check_circle_outline),
                    label: Text('Check Done'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(30),
              minHeight: 8 ,
              value:  widget.taken/widget.period,
              backgroundColor: Colors.blueAccent.withOpacity(0.3),
              stopIndicatorColor: Colors.blueAccent,
              
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}

   