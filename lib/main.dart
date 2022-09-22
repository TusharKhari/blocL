import 'package:bloc_state_mngmnt/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;
// 24
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageCubit(),
    );
  }
}
