import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(1)
  String name;

  @HiveField(2)
  String course;

  @HiveField(3)
  int age;

  Student({
    required this.name,
    required this.course,
    required this.age,
  });
}
