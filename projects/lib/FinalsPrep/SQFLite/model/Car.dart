class Car {
  final int? id;
  String name;
  String make;
  String model;

  Car({
    this.id,
    required this.name,
    required this.make,
    required this.model,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'make': make,
      'model': model,
    };
  }

  factory Car.fromMap(Map<String, dynamic> row) {
    return Car(
      id: row['id'] as int,
      name: row['name'] as String,
      make: row['make'] as String,
      model: row['model'] as String,
    );
  }
}
