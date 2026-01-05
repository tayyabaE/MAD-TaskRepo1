import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/FinalsPrep/bloc/bloc/bike_bloc.dart';
import 'package:projects/FinalsPrep/bloc/repository/bike_repository.dart';
import 'package:projects/FinalsPrep/bloc/screen/bike_screen.dart';

void main(){
  runApp(
    BlocProvider(
        create: (_) => BikeBloc(repo: BikeRepository()),
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Bloc",
      home: BikeScreen(),
    );
  }
}