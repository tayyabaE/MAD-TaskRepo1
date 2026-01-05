import 'package:flutter/material.dart';
import 'package:complete_example/SharedPref/screen/mode_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Preferences',
      home: Scaffold(
        appBar: AppBar(title: Text("Theme Mode by Shared Prefs")),
        body: ModeScreen(),
      ),
    );
  }
}