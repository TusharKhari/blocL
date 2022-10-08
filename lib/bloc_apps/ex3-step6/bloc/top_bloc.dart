import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({
    required Iterable<String> urls,
    Duration ? waitBeforeLoading,
  }) : super(
          urls: urls,
          waitBeforeLoading: waitBeforeLoading,
        );
}
