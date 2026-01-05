// providers/providers.dart
import 'package:flutter/foundation.dart';
import '../models/student.dart';

class AttendanceProvider extends ChangeNotifier {
  final List<Student> _students = [
    Student(id: 1, name: 'M. Ali '),
    Student(id: 2, name: 'M. Ahmed'),
    Student(id: 3, name: 'Amir'),
    Student(id: 4, name: 'Nouman'),
    Student(id: 5, name: 'Zafar'),
  ];

  List<Student> get students => List.unmodifiable(_students);

  void toggleAttendance(int id) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index != -1) {
      _students[index].isPresent = !_students[index].isPresent;
      notifyListeners();
    }
  }

  void markAllAbsent() {
    for (var student in _students) {
      student.isPresent = false;
    }
    notifyListeners();
  }

  int get totalPresent => _students.where((s) => s.isPresent).length;
}
