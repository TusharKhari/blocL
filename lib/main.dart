import 'package:bloc_state_mngmnt/bloc/ex1/screens/home_page_ex2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_page_cubit.dart';

// 1-19

void main() {
  runApp(const MyApp());
}

// for cubit
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: 
//       const HomePageCubit(),
//     );
//   }
// }

// for ex 1 bloc
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
     BlocProvider(
      create: (_) => PersonsBloc(),
      child: const HomePageEx1(),
     )
    );
  }
}