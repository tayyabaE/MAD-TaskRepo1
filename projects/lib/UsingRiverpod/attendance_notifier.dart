import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../UsingRiverpod/model/student.dart';

class AttendanceNotifier extends StateNotifier<List<Student>> {
  AttendanceNotifier()
      : super([
    Student(id: 1, name: 'M. Ali'),
    Student(id: 2, name: 'M. Ahmed'),
    Student(id: 3, name: 'Amir'),
    Student(id: 4, name: 'Nouman'),
    Student(id: 5, name: 'Zafar'),
  ]);

  void toggleAttendance(int id) {
    state = [
      for (final s in state)
        s.id == id ? s.copyWith(isPresent: !s.isPresent) : s,
    ];
  }

  void markAllAbsent() {
    state = [
      for (final s in state) s.copyWith(isPresent: false),
    ];
  }

  int get totalPresent => state.where((s) => s.isPresent).length;
}
