import 'package:complete_example/API_DIO/API_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:complete_example/Riverpod/screen/userScreen.dart';
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API calling using DIO',
      home: UserScreen(),
    );
  }
}
