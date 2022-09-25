import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

import '../bloc/bloc_actions.dart';
import '../bloc/persons_bloc.dart';
import '../models/persons.dart';

// loading a data from json
// first start a live server
extension Log on Object {
  void log() => devtools.log(toString());
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(
      Uri.parse(url),
    )
    .then(
      (req) => req.close(),
    )
    .then((resp) => resp.transform(utf8.decoder).join())
    .then(
      (str) => jsonDecode(str) as List<dynamic>,
    )
    .then((list) => list.map(
          (e) => Person.fromJson(e),
        ));

class HomePageEx1 extends StatefulWidget {
  const HomePageEx1({super.key});

  @override
  State<HomePageEx1> createState() => _HomePageEx1State();
}

class _HomePageEx1State extends State<HomePageEx1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc ex 2 '),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonsAction(
                        url: persons1Url,
                        loader: getPersons,
                      ),
                    );
              },
              child: const Text('Load json #1'),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonsAction(
                        url: person2Url,
                        loader: getPersons
                      ),
                    );
              },
              child: const Text('Load json #2'),
            ),
          ],
        ),
        BlocBuilder<PersonsBloc, FetchResult?>(
          buildWhen: (previousResult, currentResult) {
            return previousResult?.persons != currentResult?.persons;
          },
          builder: (context, fetchResult) {
            fetchResult?.log();
            final persons = fetchResult?.persons;
            if (persons == null) {
              return const SizedBox(
                child: Text('No Data'),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  final person = persons[index]!;
                  return ListTile(
                    title: Text(person.name),
                    subtitle: Text(person.age.toString()),
                  );
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}
