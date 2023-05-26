import 'package:bloc/bloc.dart';
import 'package:flutter_todos/stats/bloc/stats_event.dart';
import 'package:flutter_todos/stats/bloc/stats_state.dart';
import 'package:todos_repository/todos_repository.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const StatsState()) {
    on<StatsSubscriptionRequest>(_onSubscriptionRequested);
  }

  final TodosRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
      StatsSubscriptionRequest event, Emitter<StatsState> emit) async {
    emit(state.copyWith(status: StatsStatus.loading));

    await emit.forEach<List<Todo>>(_todosRepository.getTodos(),
        onData: (todos) => state.copyWith(
            status: StatsStatus.success,
            completedTodos: todos.where((todo) => todo.isCompleted).length,
            activeTodos: todos.where((todo) => !todo.isCompleted).length));
  }
}
