import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;

void main() {
  return runApp(
    const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

const names = ['Foo', 'Bar', 'Baz'];

extension RandomElement<T> on Iterable<T> {
  T getRadomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRadomElement());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NamesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          final button = TextButton(
            onPressed: () => cubit.pickRandomName(),
            child: const Text("Pick a random name"),
          );
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return button;

            case ConnectionState.waiting:
              return button;

            case ConnectionState.active:
              return Column(
                children: [
                  Text(snapshot.data ?? ''),
                  button,
                ],
              );

            case ConnectionState.done:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
