import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/UsingRiverpod/attendance_notifier.dart';
import 'package:projects/UsingRiverpod/model/student.dart';

final attendanceProvider =
StateNotifierProvider<AttendanceNotifier, List<Student>>(
      (ref) => AttendanceNotifier(),
);
