// // homePage.dart
// import 'package:flutter/material.dart';
// import 'package:library_provider/library_provider.dart';
// import 'providers/attendance_provider.dart';
// import 'views/attendance_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AttendanceProvider(),
//       child: MaterialApp(
//         title: 'Attendance App',
//         theme: ThemeData(
//           primarySwatch: Colors.teal,
//         ),
//         home: AttendanceScreen(),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/UsingRiverpod/view/attendance_screen.dart';

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
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AttendanceScreen(),
    );
  }
}
