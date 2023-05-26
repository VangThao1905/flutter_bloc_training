import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_event.dart';

@visibleForTesting
enum TodosOverviewOption { toggleAll, clearCompleted }

class TodosOverviewOptionsButton extends StatelessWidget {
  const TodosOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.select((TodosOverviewBloc bloc) => bloc.state.todos);
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        tooltip: 'Options',
        onSelected: (options) {
          switch (options) {
            case TodosOverviewOption.toggleAll:
              context
                  .read<TodosOverviewBloc>()
                  .add(const TodosOverviewToggleAllRequested());
              break;
            case TodosOverviewOption.clearCompleted:
              context
                  .read<TodosOverviewBloc>()
                  .add(const TodosOverviewClearCompletedRequested());
              break;
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: TodosOverviewOption.toggleAll,
                enabled: hasTodos,
                child: Text(completedTodosAmount == todos.length
                    ? 'Mark all is incomplete'
                    : 'Mark all is completed')),
            PopupMenuItem(
                value: TodosOverviewOption.clearCompleted,
                enabled: hasTodos && completedTodosAmount > 0,
                child: const Text('clear completed'))
          ];
        },
        icon: const Icon(Icons.more_vert_rounded));
  }
}
