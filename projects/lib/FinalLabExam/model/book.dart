// models/book.dart
class Book {
  final int id;
  final String title;

  bool isExist;

  Book({
    required this.id,
    required this.title,
    this.isExist = false,
  });
}
