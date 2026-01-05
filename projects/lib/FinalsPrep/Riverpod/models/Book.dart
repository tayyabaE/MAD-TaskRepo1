class Book {
  final int id;
  String title;
  String author;
  bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.isAvailable = false,
  });
}
