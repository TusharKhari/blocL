//

import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/app_state.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/bloc_events.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);
typedef AppBlocUrlLoader = Future<Uint8List> Function(String url);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) =>

      //
      allUrls.getRandomElement();

  Future<Uint8List> _loadUrl(String url) =>
      //
      NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((byteData) => byteData.buffer.asUint8List());
  AppBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    AppBlocRandomUrlPicker? urlPicker,
    AppBlocUrlLoader? urlLoader,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoadNextUrlEvent>(
      (event, emit) async {
        // start loading
        emit(
          const AppState(
            isLoading: true,
            data: null,
            error: null,
          ),
        );
        final url = (urlPicker ?? _pickRandomUrl)(urls);
        try {
          if (waitBeforeLoading != null) {
            await Future.delayed(waitBeforeLoading);
          }
          // final bundle = NetworkAssetBundle(Uri.parse(url));
          // final data = (await bundle.load(url)).buffer.asUint8List();
          final data =await (urlLoader ?? _loadUrl)(url);
          emit(
            AppState(
              isLoading: false,
              data: data,
              error: null,
            ),
          );
        } catch (e) {
          emit(
            AppState(
              isLoading: false,
              data: null,
              error: e,
            ),
          );
        }
      },
    );
  }
}
