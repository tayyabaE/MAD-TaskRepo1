import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../library_provider/library_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LibraryProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      home: const LibraryScreen(),
    );
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LibraryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Library Tracker",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      /// Floating Actions
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: "available",
            backgroundColor: Colors.blue,
            onPressed: () {
              context
                  .read<LibraryProvider>()
                  .markAllAvailable();
            },
            label: const Text("All Available"),
            icon: const Icon(Icons.done_all),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: "issued",
            backgroundColor: Colors.orange,
            onPressed: () {
              context
                  .read<LibraryProvider>()
                  .markAllIssued();
            },
            label: const Text("All Issued"),
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Info Text
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Available books: ${provider.availableBooksCount}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// Book List
          Expanded(
            child: ListView.builder(
              itemCount: provider.books.length,
              itemBuilder: (_, index) {
                final book = provider.books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(
                    book.isExist ? "Available" : "Issued",
                    style: TextStyle(
                      color: book.isExist
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  trailing: Checkbox(
                    value: book.isExist,
                    onChanged: (_) {
                      context
                          .read<LibraryProvider>()
                          .toggleBookAvailability(book.id);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
