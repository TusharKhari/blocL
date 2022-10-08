import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/app_bloc.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/bottom_bloc.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/bloc/top_bloc.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/models/constants.dart';
import 'package:bloc_state_mngmnt/bloc_apps/ex3-step6/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageEx3 extends StatelessWidget {
  const HomePageEx3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (_) => TopBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
            BlocProvider<BottomBloc>(
              create: (_) => BottomBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
