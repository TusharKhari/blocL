//
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_actions.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_block.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/bloc/app_state.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/data/login_api.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/data/note_api.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/dialogs/generic_dialog.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/dialogs/loading_screen.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/models/models.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/models/string.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/views/iterable_list_view.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/views/login_button.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex2-step4/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainEx2 extends StatefulWidget {
  const MainEx2({super.key});

  @override
  State<MainEx2> createState() => _MainEx2State();
}

class _MainEx2State extends State<MainEx2> {
  @override
  Widget build(BuildContext context) {
    return
        //
        BlocProvider(
      create: (context) => AppBloc(
        acceptedLoginHandle: const LoginHandle.fooBar(),
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            // take care of loading screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            // display possible errors in app
            final loginError = appState.loginError;
            if (loginError != null) {
              showGenericDialog<bool>(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {
                  ok: true,
                },
              );
            }
            // if we are logged in , but he have no fetched notes
            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.fooBar() &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(
                    const LoadNotesAction(),
                  );
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                (email, password) {
                  context.read<AppBloc>().add(LoginAction(
                        email: email,
                        password: password,
                      ),);
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
    // Scaffold(
    //   body: LoginScreenEx2(),
    // );
  }
}
