import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/bloc/bloc_actions.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/bloc/persons_bloc.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/models/persons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPerson1 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 20,
  ),
];

const mockedPerson2 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 20,
  ),
];

Future<Iterable<Person>> mockGetPerson1(String _) =>
    Future.value(mockedPerson1);

Future<Iterable<Person>> mockGetPerson2(String _) =>
    Future.value(mockedPerson2);

void main() {
  group('Testing bloc', () {
    // write our tests

    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'test initial state',
      build: () => bloc,
      verify: (bloc) => expect(
        bloc.state,
      // const FetchResult(persons: [], isRetrievedFromCache: false),
      null,
      ),
    );

    // fetch mock data (persons1) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_1',
            loader: mockGetPerson1,
          ),
        );
        // after caching
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_1',
            loader: mockGetPerson1,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPerson1,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPerson1,
          isRetrievedFromCache: true,
        ),
      ],
    );

    // fetch mock data (persons2) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retrieving persons from second iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_2',
            loader: mockGetPerson2,
          ),
        );
        // after caching
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_2',
            loader: mockGetPerson2,
          ),
        );
      },
      expect: () => [
        const FetchResult(
          persons: mockedPerson2,
          isRetrievedFromCache: false,
        ),
        const FetchResult(
          persons: mockedPerson2,
          isRetrievedFromCache: true,
        ),
      ],
    );
  });
}
