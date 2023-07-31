import 'package:equatable/equatable.dart';

import 'package:bloc_app/data/models/todo.dart';

abstract class TodosState extends Equatable {}

class InitialState extends TodosState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends TodosState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends TodosState {
  final List<Todo> todos;
  LoadedState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class ErrorState extends TodosState {
  final String error;
  ErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}