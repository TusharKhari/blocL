import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/bloc/persons_bloc.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/screens/home_page_ex1.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/mEx2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// 5 18 

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

// for ex 1 bloc step 2
// ignore: slash_for_doc_comments
/**
this ex loads data from json from a file and we have to start a live server so 
data come from url  and saves and also saving that data in another map so we don't 
have to call url again
//  */
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: 
//      BlocProvider(
//       create: (_) => PersonsBloc(),
//       child: const HomePageEx1(),
//      )
//     );
//   }
// }


// ex 2 s4 notes taking app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: 
    MainEx2(),
    );
  }
}

