import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/attendance_controller.dart';
import '../provider/providers.dart';

class AttendanceScreen extends ConsumerWidget {
  AttendanceScreen({super.key});

  final AttendanceController _controller = AttendanceController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(attendanceProvider); // List<Student>
    final totalPresent = students.where((s) => s.isPresent).length;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text("Attendance"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blueGrey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 28),
                    Text("Present: $totalPresent"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.cancel, color: Colors.red, size: 28),
                    Text("Absent: ${students.length - totalPresent}"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Student List
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    title: Text(student.name),
                    trailing: Switch(
                      value: student.isPresent,
                      onChanged: (_) {
                        _controller.markAttendance(ref, student.id);
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),

          // Mark All Absent Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                ref.read(attendanceProvider.notifier).markAllAbsent();
              },
              icon: const Icon(Icons.cancel),
              label: const Text("Mark All Absent"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
