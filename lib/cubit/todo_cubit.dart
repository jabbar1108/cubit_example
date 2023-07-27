import 'package:bloc/bloc.dart';
import 'package:bloc_app/cubit/todo_state.dart';
import 'package:bloc_app/data/TodosRepository.dart';

class TodoCubit extends Cubit<TodosState> {
  final TodosRepository repository;

  TodoCubit({required this.repository}) : super(InitialState());

  void getAllTodos() async {
    try {
      emit(LoadingState());
      final todos = await repository.getTodosData();
      emit(LoadedState(todos: todos));
    } catch(error) {
      emit(ErrorState(error: error.toString()));
    }
  }
}