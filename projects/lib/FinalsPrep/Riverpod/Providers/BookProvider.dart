import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/FinalsPrep/Riverpod/models/Book.dart';

List<Book> initialBooks = [
  Book(id: 1, title: 'Programming Fundamentals', author: 'Ali'),
  Book(id: 2, title: 'Mobile App Dev', author: 'Ahmed'),
  Book(id: 3, title: 'Data Structures', author: 'Sara'),
  Book(id: 4, title: 'AI Basics', author: 'Usman'),
  Book(id: 5, title: 'Flutter Dev', author: 'Ayesha'),
];

class BookProvider extends StateNotifier<List<Book>> {
  BookProvider() : super(initialBooks);

  void toggleAvailable (int id){
    final i = state.indexWhere((b) => b.id == id);
    if(i != -1){
      state[i].isAvailable = !state[i].isAvailable;
      state = [...state];
    }
  }

  void add (Book B){
    state.add(B);
    state = [...state];
  }

  void update (Book B){
    final i = state.indexWhere((b) => b.id ==B.id);
    if (i != -1){
      state[i].title = B.title;
      state[i].author = B.author;
      state = [...state];
    }
  }


  void delete(Book B){
    final i = state.indexWhere((b) => b.id == B.id);
    if(i != -1){
      state.remove(B);
      state = [...state];
    }
  }

  void markAllUnavailable(){
    for (var B in state){
      B.isAvailable = false;
    }
    state = [...state];
  }
  void markAllAvailable(){
    for (var B in state){
      B.isAvailable = true;
    }
    state = [...state];
  }

  int get totalAvailableBooks => state.where((b) => b.isAvailable).length;
  int get totalUnavailableBooks => state.where((b) => !b.isAvailable).length;

  Book getOne(int id) => state.singleWhere((b) => b.id == id);

}

final bookProvider =
    StateNotifierProvider<BookProvider, List<Book>>(
        (ref) => BookProvider()
    );
