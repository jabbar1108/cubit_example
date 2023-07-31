import 'package:bloc_app/cubit/todo_cubit.dart';
import 'package:bloc_app/cubit/todo_state.dart';
import 'package:bloc_app/data/repositories/TodosRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  return runApp(
    MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TodoCubit>(
        create: (context) => TodoCubit(
          repository: TodosRepository(),
        ),
        child: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoCubit>().getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoCubit, TodosState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(state.error,
                  style: const TextStyle(
                    color: Colors.red,
                  )),
            ],
          );
        } else if (state is LoadedState) {
          final todos = state.todos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 12,
                child: ListTile(
                  title: Text(
                    todos[index].title,
                    style: TextStyle(
                      color: todos[index].completed
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
