// controllers/attendance_controller.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class AttendanceController {
  void markAttendance(BuildContext context, int id) {
    Provider.of<AttendanceProvider>(context, listen: false).toggleAttendance(id);
  }

  int getTotalPresent(BuildContext context) {
    return Provider.of<AttendanceProvider>(context, listen: false).totalPresent;
  }
}
