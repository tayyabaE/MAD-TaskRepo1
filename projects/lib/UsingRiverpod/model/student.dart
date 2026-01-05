class Student {
  final int id;
  final String name;
  final bool isPresent;

  Student({
    required this.id,
    required this.name,
    this.isPresent = false,
  });

  Student copyWith({
    int? id,
    String? name,
    bool? isPresent,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
