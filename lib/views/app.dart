import 'package:bloc_state_mngmnt/bloc/app_bloc.dart';
import 'package:bloc_state_mngmnt/bloc/app_event.dart';
import 'package:bloc_state_mngmnt/dialogs/show_auth_error.dart';
import 'package:bloc_state_mngmnt/loading/loading_screen.dart';
import 'package:bloc_state_mngmnt/views/login_view.dart';
import 'package:bloc_state_mngmnt/views/photo_gallery_view.dart';
import 'package:bloc_state_mngmnt/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_state.dart';
import '../main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()
        ..add(
          const AppEventInitialize(),
        ),
      child: MaterialApp(
        title: 'Photo Library',
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading',
              );
            } else {
              LoadingScreen.instance().hide();
            }
            final authError = appState.authError;
            if (authError != null) {
              showAuthError(authError: authError, context: context);
            }
          },
          builder: (context, appState) {
            if (appState is AppStateLoggedOut) {
              return const LoginView();
            } else if (appState is AppStateLoggedIn) {
              return const PhotoGalleryView();
            } else if (appState is AppStateIsInRegistrationView) {
              return const RegisterView();
            } else {
              // this should never happen
              return Container();
            }
          },
        ),
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('firebase in bloc'),
//       ),
//       body: const Text(''),
//     );
//   }
// }
