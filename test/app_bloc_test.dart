// flutter test

// ex 2 step 4 test
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_actions.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_block.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/data/login_api.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/data/note_api.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

//
const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note>? notesToReturnForAcceptedLoginHandle;
  const DummyNotesApi({
    required this.acceptedLoginHandle,
    this.notesToReturnForAcceptedLoginHandle,
  });

  const DummyNotesApi.empty()
      : acceptedLoginHandle = const LoginHandle.fooBar(),
        notesToReturnForAcceptedLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) async {
    if (loginHandle == acceptedLoginHandle) {
      return notesToReturnForAcceptedLoginHandle;
    } else {
      return null;
    }
  }
}

@immutable
class DummyLoginApi implements LoginApiProtocol {
  final String acceptedEmail;
  final String acceptedPassword;
  final LoginHandle handleToReturn;
  const DummyLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
    required this.handleToReturn,
  });

  const DummyLoginApi.empty()
      : acceptedEmail = '',
        acceptedPassword = '',
        handleToReturn = const LoginHandle.fooBar();
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return handleToReturn;
    } else {
      return null;
    }
  }
}

const acceptedLoginHandle = LoginHandle(token: 'ABC');

void main() {
  blocTest<AppBloc, AppState>(
    'Initial state of the block should be AppState.empty()',
    build: () => AppBloc(
      acceptedLoginHandle: acceptedLoginHandle,
      loginApi: const DummyLoginApi.empty(),
      notesApi: const DummyNotesApi.empty(),
    ),
    verify: (appState) => expect(
      appState.state,
      const AppState.empty(),
    ),
  );
  blocTest<AppBloc, AppState>(
    ' can we login with correct credentials ?',
    build: () => AppBloc(
      acceptedLoginHandle: acceptedLoginHandle,
      loginApi: const DummyLoginApi(
        acceptedEmail: 'bar@boo.com',
        acceptedPassword: 'foo',
        handleToReturn: acceptedLoginHandle,
      ),
      notesApi: const DummyNotesApi.empty(),
    ),
    act: (appBloc) => appBloc.add(
      const LoginAction(
        email: 'bar@baz.com',
        password: 'foo',
      ),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
    ],
  );
  blocTest<AppBloc, AppState>(
    'we should not be able to log in with invalid credentials',
    build: () => AppBloc(
      acceptedLoginHandle: acceptedLoginHandle,
      loginApi: const DummyLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'baz',
        handleToReturn: acceptedLoginHandle,
      ),
      notesApi: const DummyNotesApi.empty(),
    ),
    act: (appBloc) => appBloc.add(
      const LoginAction(
        email: 'bar@baz.com',
        password: 'foo',
      ),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: LoginErrors.invalidHandle,
        loginHandle: null,
        fetchedNotes: null,
      ),
    ],
  );

  blocTest<AppBloc, AppState>(
    'Load some notes with a valid login handle',
    build: () => AppBloc(
      acceptedLoginHandle: acceptedLoginHandle,
      loginApi: const DummyLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'baz',
        handleToReturn: acceptedLoginHandle,
      ),
      notesApi: const DummyNotesApi(
        acceptedLoginHandle: acceptedLoginHandle,
        notesToReturnForAcceptedLoginHandle: mockNotes,
      ),
    ),
    act: (appBloc) {
      appBloc.add(
        const LoginAction(
          email: 'foo@bar.com',
          password: 'baz',
        ),
      );

      appBloc.add(
        const LoadNotesAction(),
      );
    },
    expect: () => [
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: mockNotes,
      ),
    ],
  );
}



//===============================
// bloc ex 1 step 2
// file name persons_bloc_test.dart

// import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/bloc/bloc_actions.dart';
// import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/bloc/persons_bloc.dart';
// import 'package:bloc_state_mngmnt/bloc_apps/ex1-step2/models/persons.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';

// const mockedPerson1 = [
//   Person(
//     name: 'Foo',
//     age: 20,
//   ),
//   Person(
//     name: 'Bar',
//     age: 20,
//   ),
// ];

// const mockedPerson2 = [
//   Person(
//     name: 'Foo',
//     age: 20,
//   ),
//   Person(
//     name: 'Bar',
//     age: 20,
//   ),
// ];

// Future<Iterable<Person>> mockGetPerson1(String _) =>
//     Future.value(mockedPerson1);

// Future<Iterable<Person>> mockGetPerson2(String _) =>
//     Future.value(mockedPerson2);

// void main() {
//   group('Testing bloc', () {
//     // write our tests

//     late PersonsBloc bloc;

//     setUp(() {
//       bloc = PersonsBloc();
//     });

//     blocTest<PersonsBloc, FetchResult?>(
//       'test initial state',
//       build: () => bloc,
//       verify: (bloc) => expect(
//         bloc.state,
//       // const FetchResult(persons: [], isRetrievedFromCache: false),
//       null,
//       ),
//     );

//     // fetch mock data (persons1) and compare it with FetchResult
//     blocTest<PersonsBloc, FetchResult?>(
//       'Mock retrieving persons from first iterable',
//       build: () => bloc,
//       act: (bloc) {
//         bloc.add(
//           const LoadPersonsAction(
//             url: 'dummy_url_1',
//             loader: mockGetPerson1,
//           ),
//         );
//         // after caching
//         bloc.add(
//           const LoadPersonsAction(
//             url: 'dummy_url_1',
//             loader: mockGetPerson1,
//           ),
//         );
//       },
//       expect: () => [
//         const FetchResult(
//           persons: mockedPerson1,
//           isRetrievedFromCache: false,
//         ),
//         const FetchResult(
//           persons: mockedPerson1,
//           isRetrievedFromCache: true,
//         ),
//       ],
//     );

//     // fetch mock data (persons2) and compare it with FetchResult
//     blocTest<PersonsBloc, FetchResult?>(
//       'Mock retrieving persons from second iterable',
//       build: () => bloc,
//       act: (bloc) {
//         bloc.add(
//           const LoadPersonsAction(
//             url: 'dummy_url_2',
//             loader: mockGetPerson2,
//           ),
//         );
//         // after caching
//         bloc.add(
//           const LoadPersonsAction(
//             url: 'dummy_url_2',
//             loader: mockGetPerson2,
//           ),
//         );
//       },
//       expect: () => [
//         const FetchResult(
//           persons: mockedPerson2,
//           isRetrievedFromCache: false,
//         ),
//         const FetchResult(
//           persons: mockedPerson2,
//           isRetrievedFromCache: true,
//         ),
//       ],
//     );
//   });
// }
