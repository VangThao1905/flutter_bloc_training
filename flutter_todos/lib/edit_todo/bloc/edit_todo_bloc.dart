import 'package:bloc/bloc.dart';
import 'package:flutter_todos/edit_todo/bloc/edit_todo_event.dart';
import 'package:flutter_todos/edit_todo/bloc/edit_todo_state.dart';
import 'package:todos_repository/todos_repository.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc(
      {required TodosRepository todosRepository, required Todo? initialTodo})
      : _todosRepository = todosRepository,
        super(EditTodoState(
            initialTodo: initialTodo,
            title: initialTodo?.title ?? '',
            description: initialTodo?.description ?? '')) {
    on<EditTodoTitleChanged>(_onTitleChanged);
    on<EditTodoDescriptionChanged>(_onDescriptionChanged);
    on<EditTodoSubmitted>(_onSubmitted);
  }

  final TodosRepository _todosRepository;

  void _onTitleChanged(
      EditTodoTitleChanged event, Emitter<EditTodoState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
      EditTodoDescriptionChanged event, Emitter<EditTodoState> emit) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
      EditTodoSubmitted event, Emitter<EditTodoState> emit) async {
    emit(state.copyWith(status: EditTodoStatus.loading));
    if (state.title.isNotEmpty && state.description.isNotEmpty) {
      final todo = (state.initialTodo ?? Todo(title: ''))
          .copyWith(title: state.title, description: state.description);
      try {
        await _todosRepository.saveTodo(todo);
        emit(state.copyWith(status: EditTodoStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EditTodoStatus.failure));
      }
    } else {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }
}
