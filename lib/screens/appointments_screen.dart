
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(width: 10),
            ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage("lib/assets/profile_logo.png"),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
          ],
        ),
        title: const Text('Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                FilterChip(label: Text("All 4"), onSelected: (_) {}),
                SizedBox(width: 8),
                FilterChip(label: Text("Upcoming 2"), onSelected: (_) {}),
                SizedBox(width: 8),
                FilterChip(label: Text("Past 2"), onSelected: (_) {}),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: List.generate(4, (index) {
                  bool isUpcoming = index < 2;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('lib/assets/profile_logo.png'),
                      ),
                      title: Text('Abdullah Hussein'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Heart Dx'),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 14),
                              SizedBox(width: 4),
                              Text('13, Nov 2025'),
                            ],
                            
                          ),
                          Row(
                            children: [
                              Icon(Icons.punch_clock, size: 14),
                              SizedBox(width: 4),
                              Text('9:00 - 9:30 PM'),
                            ],
                            
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14),
                              SizedBox(width: 4),
                              Text('Aman Private Hospital'),
                            ],
                          ),
                        ],
                      ),
                      trailing: isUpcoming
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('25:01:30:15', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('left'),
                              ],
                            )
                          : const Icon(Icons.check_circle, color: Colors.green),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
