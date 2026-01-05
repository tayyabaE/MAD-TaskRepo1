import 'package:complete_example/SQF_Lite/screen/user_Screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("SQF Lite")),
        body: UserScreen(),
      ),
    );
  }
}