
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/main_s6.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//  
// 
// https://github.com/vandadnp/youtube-course-bloc
// 6 48 

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainStep6(),
    );
  }
}
