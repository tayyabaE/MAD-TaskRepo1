// views/attendance_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';
import '../controllers/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  final AttendanceController _controller = AttendanceController();

  AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text("Attendance"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Summary at the top
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blueGrey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 28),
                    const SizedBox(height: 4),
                    Text(
                      "Present: ${attendanceProvider.totalPresent}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.cancel, color: Colors.red, size: 28),
                    const SizedBox(height: 4),
                    Text(
                      "Absent: ${attendanceProvider.students.length - attendanceProvider.totalPresent}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Student list
          Expanded(
            child: ListView.builder(
              itemCount: attendanceProvider.students.length,
              itemBuilder: (context, index) {
                final student = attendanceProvider.students[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    title: Text(student.name),
                    trailing: Switch(
                      value: student.isPresent,
                      onChanged: (_) {
                        _controller.markAttendance(context, student.id);
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),

          // Mark All Absent button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                attendanceProvider.markAllAbsent();
              },
              icon: const Icon(Icons.cancel),
              label: const Text("Mark All Absent"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
