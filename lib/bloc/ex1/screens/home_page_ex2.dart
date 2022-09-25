import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

// loading a data from json
// first start a live server
extension Log on Object {
  void log() => devtools.log(toString());
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final PersonUrl url;
  const LoadPersonsAction({required this.url}) : super();
}

enum PersonUrl {
  person1,
  person2,
}

// const List<String> names = ['foo', "bar"];

// void testIt() {
//   final baz = names[2];
// }

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return "http://127.0.0.1:5500/lib/bloc/ex2/api/persons1.json";

      case PersonUrl.person2:
        return "http://127.0.0.1:5500/lib/bloc/ex2/api/persons2.json";
    }
  }
}

@immutable
class Person {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        age = json["age"] as int;

  @override
  String toString() => "Pesron (name: $name, age: $age)";
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

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });
  @override
  String toString() =>
      "FetchResult (isRetrievedFromCache = $isRetrievedFromCache, persons = $persons)";
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;
        if (cache.containsKey(url)) {
          // we have the value in the cache
          final cachedPersons = cache[url]!;
          final result = FetchResult(
            persons: cachedPersons,
            isRetrievedFromCache: true,
          );
          emit(result);
        } else {
          final persons = await getPersons(url.urlString);
          cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}

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
        title: const Text("Bloc ex 2 "),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(const LoadPersonsAction(
                      url: PersonUrl.person1,
                    ));
              },
              child: const Text("Load json #1"),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(const LoadPersonsAction(
                      url: PersonUrl.person2,
                    ));
              },
              child: const Text("Load json #2"),
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
                child: Text("No Data"),
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
