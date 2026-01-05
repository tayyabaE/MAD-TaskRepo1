import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/FinalsPrep/Riverpod/Providers/BookProvider.dart';
import 'package:projects/FinalsPrep/Riverpod/models/Book.dart';

class BookScreen extends ConsumerWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Book> books = ref.watch(bookProvider);
    final notifier = ref.watch(bookProvider.notifier);

    final TextEditingController idController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController authorController = TextEditingController();

    void clearFields() {
      idController.clear();
      titleController.clear();
      authorController.clear();
    }

    void addHandler() {
      if (idController.text.isEmpty ||
          titleController.text.isEmpty ||
          authorController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("All fields required"))
        );
        return;
      }
      Book b = Book(id: int.parse(idController.text), title: titleController.text, author: authorController.text);
      notifier.add(b);
      clearFields();
    }

    void updateHandler() {
      if(idController.text.isEmpty || titleController.text.isEmpty || authorController.text.isEmpty ){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("All fields required"))
        );
        return;
      }
      Book b = Book( id: int.parse(idController.text), title: titleController.text, author: authorController.text);
      notifier.update(b);
      clearFields();
    }

    void getOne(int id) {
      Book b = notifier.getOne(id);
      idController.text = b.id.toString();
      titleController.text = b.title;
      authorController.text = b.author;
    }

    void deleteHandler(Book b) {
      notifier.delete(b);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Book Deleted")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Books List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text('Total Books: ${books.length}'),
            Text('Available: ${notifier.totalAvailableBooks}'),
            Text('Unavailable: ${notifier.totalUnavailableBooks}'),

            const SizedBox(height: 10),

            TextFormField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Book Id'),

            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),

            Row(
              children: [
                ElevatedButton(onPressed: clearFields, child: const Text('Reset')),
                ElevatedButton(onPressed: addHandler, child: const Text('Add')),
                ElevatedButton(onPressed: updateHandler, child: const Text('Update')),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return ListTile(
                    title: Text(
                        '${book.title} (${book.isAvailable ? 'Available' : 'Unavailable'})'),
                    subtitle: Text(book.author),
                    trailing: Switch(
                      value: !book.isAvailable,
                      onChanged: (_) => notifier.toggleAvailable(book.id),
                    ),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => getOne(book.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteHandler(book),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              children: [
                ElevatedButton(
                  onPressed: notifier.markAllUnavailable,
                  child: const Text('Mark All Unavailable'),
                ),
                ElevatedButton(
                  onPressed: notifier.markAllAvailable,
                  child: const Text('Mark All Available'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
