import 'package:flutter/material.dart';
import '../model/book.dart';

class LibraryProvider extends ChangeNotifier {
  final List<Book> _books = [
    Book(id: 1, title: "Book1"),
    Book(id: 2, title: "Book2"),
    Book(id: 3, title: "Book3"),
    Book(id: 4, title: "Book4")
  ];

  List<Book> get books => _books;

  int get availableBooksCount =>
      _books.where((book) => book.isExist).length;

  void toggleBookAvailability(int id) {
    final book = _books.firstWhere((b) => b.id == id);
    book.isExist = !book.isExist;
    notifyListeners();
  }

  void markAllAvailable() {
    for (var book in _books) {
      book.isExist = true;
    }
    notifyListeners();
  }

  void markAllIssued() {
    for (var book in _books) {
      book.isExist = false;
    }
    notifyListeners();
  }
}
