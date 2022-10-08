import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/app_bloc.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/app_state.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/bloc_events.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/extensions/streams/start_with.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 20),
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, appState) {
          if (appState.error != null) {
            return const Text('an error occurred');
          } else if (appState.data != null) {
            // we have data
            return Image.memory(
              appState.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            // loading state
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
