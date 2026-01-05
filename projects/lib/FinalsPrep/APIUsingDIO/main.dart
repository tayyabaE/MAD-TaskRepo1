import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/FinalsPrep/Riverpod/book_screen.dart';
import 'package:projects/FinalsPrep/APIUsingDIO/API_CallingUsing%20DIO.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Prep',
      home: APIScreen(),
    );
  }
}
