import 'package:flutter/material.dart';

class HomeScreenEx2 extends StatefulWidget {
  const HomeScreenEx2({super.key});

  @override
  State<HomeScreenEx2> createState() => _HomeScreenEx2State();
}

class _HomeScreenEx2State extends State<HomeScreenEx2> {
  List noteTitList = ['Note 1', 'Note 2', 'Note 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
      ),
      body: ListView.builder(
        itemCount: noteTitList.length,
        itemBuilder: (context, index) {
          return Text(noteTitList[index]);
        },
      ),
    );
  }
}
