import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/UsingRiverpod/provider/providers.dart';
import '../attendance_notifier.dart';
import 'package:projects/UsingRiverpod/model/student.dart';

class AttendanceController {
  void markAttendance(WidgetRef ref, int id) {
    ref.read(attendanceProvider.notifier).toggleAttendance(id);
  }

  int getTotalPresent(WidgetRef ref) {
    return ref.read(attendanceProvider.notifier).totalPresent;
  }
}
