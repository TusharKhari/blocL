import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_actions.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_state.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/data/login_api.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/data/note_api.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
  final LoginHandle acceptedLoginHandle;
  AppBloc({  required this.acceptedLoginHandle, 
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        // start loading
        emit(
          const AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );
        // log the user in
        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );
        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );
    on<LoadNotesAction>((event, emit) async {
      // start loading
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
      // get the login handle
      final loginHandle = state.loginHandle;
      if (loginHandle != acceptedLoginHandle) {
        // invalid login handle, can't fetch notes
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      } else {
        // we have a valid login handle and want to fetch notes
        final notes = await notesApi.getNotes(
          loginHandle: loginHandle!,
        );
        emit(
          AppState(
            isLoading: false,
            loginError: LoginErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      }
    });
  }
}
