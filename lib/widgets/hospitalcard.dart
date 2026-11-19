import 'package:flutter/material.dart';

class HospitalCard extends StatefulWidget {
  const HospitalCard({
    super.key,
    required this.hospitalName,
    required this.hospitalType,
    required this.hospitalRating,
    required this.hospitalCity,
    required this.hospitalDistance,
    this.hospitalImage = 'lib/assets/Hospital.jpg',
    required this.hospitalPhone,
    required this.hospitalLocation,
    this.hours = 24,
  });

  final String hospitalName;
  final String hospitalType;
  final String hospitalRating;
  final String hospitalDistance;
  final String hospitalCity;
  final String hospitalImage;
  final String hospitalPhone;
  final String hospitalLocation;
  final int hours;

  @override
  State<HospitalCard> createState() => _HospitalCardState();
}

class _HospitalCardState extends State<HospitalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 163,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 242, 242),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.hospitalImage,
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
                    widget.hospitalName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.hospitalRating,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const Icon(Icons.star, color: Colors.yellow),
                      Container(
                        width: 1,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.grey,
                      ),
                      Text(
                        widget.hospitalType,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'open ${widget.hours} hours',
                        style: const TextStyle(color: Colors.green),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.grey,
                      ),
                      Text(
                        widget.hospitalDistance,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.grey,
                      ),
                      Text(
                        widget.hospitalCity,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.pin_drop_outlined),
                  label: const Text('Directions'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
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
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_outlined),
                    label: const Text('Call'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
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
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_calendar_outlined),
                  label: const Text('Book', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
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
        ],
      ),
    );
  }
}
