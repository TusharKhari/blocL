import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

const List names = [
  "foo",
  "bar",
  "Baz",
];

extension RandomElement<T> on Iterable<T> {
  //get math => null;

  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

// extension RandomElement<T> on Iterable<T> {
//   get math => null;

// }

class NamesCubit extends Cubit<String?> {
  //NamesCubit(super.initialState);
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRandomElement());
}

class HomePageCubit extends StatefulWidget {
  const HomePageCubit({super.key});

  @override
  State<HomePageCubit> createState() => _HomePageCubitState();
}

class _HomePageCubitState extends State<HomePageCubit> {
  // final n = NamesCubit();
  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  late final NamesCubit cubit;

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("bloc tutorial"),
        ),
        body: StreamBuilder<String?>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final button = TextButton(
              onPressed: () {
                cubit.pickRandomName();
              },
              child: const Text("pick a random name"),
            );
            //return const Text('data');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;
              case ConnectionState.waiting:
                return button;
              case ConnectionState.active:
                return Column(
                  children: [
                    Text(snapshot.data ?? ""),
                    button,
                  ],
                );

              case ConnectionState.done:
                return const SizedBox();
            }
          },
        ));
  }
}
