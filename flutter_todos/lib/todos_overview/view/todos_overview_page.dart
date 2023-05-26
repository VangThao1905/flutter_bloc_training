import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/edit_todo/view/edit_todo_page.dart';
import 'package:flutter_todos/localization/language_constants.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:flutter_todos/todos_overview/bloc/todos_overview_event.dart';
import 'package:flutter_todos/todos_overview/widgets/todo_list_tile.dart';
import 'package:flutter_todos/todos_overview/widgets/todos_overview_change_language.dart';
import 'package:flutter_todos/todos_overview/widgets/todos_overview_filter_button.dart';
import 'package:flutter_todos/todos_overview/widgets/todos_overview_options_buttton.dart';
import 'package:todos_repository/todos_repository.dart';

import '../bloc/todos_overview_state.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodosOverviewBloc(todosRepository: context.read<TodosRepository>())
            ..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(getTranslated(context, 'myNoteBook')),
        actions: const [
          TodosOverviewFilterButton(),
          TodosOverviewOptionsButton(),
          TodosOverviewChangeLanguageButton()
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == TodosOverviewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(const SnackBar(
                        content:
                            Text('An error occurred while loading todos')));
                }
              }),
          BlocListener<TodosOverviewBloc, TodosOverviewState>(
              listenWhen: (previous, current) =>
                  previous.lastDeletedTodo != current.lastDeletedTodo &&
                  current.lastDeletedTodo != null,
              listener: (context, state) {
                final deletedTodo = state.lastDeletedTodo!;
                final messenger = ScaffoldMessenger.of(context);
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Todo ${deletedTodo.title} deleted'),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          messenger.hideCurrentSnackBar();
                          context
                              .read<TodosOverviewBloc>()
                              .add(const TodosOverviewUndoDeletionRequested());
                        }),
                  ));
              })
        ],
        child: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosOverviewStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status != TodosOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                    child: Text(
                  'No todos found with the selected filter',
                  style: Theme.of(context).textTheme.bodySmall,
                ));
              }
            }

            return CupertinoScrollbar(
                child: ListView(
              children: [
                for (final todo in state.filteredTodos)
                  TodoListTile(
                    todo: todo,
                    onToggleCompleted: (isCompleted) {
                      context.read<TodosOverviewBloc>().add(
                          TodosOverviewTodoCompletionToggled(
                              todo: todo, isCompleted: isCompleted));
                    },
                    onDismissed: (_) {
                      context
                          .read<TodosOverviewBloc>()
                          .add(TodosOverviewTodoDeleted(todo));
                    },
                    onTap: () {
                      Navigator.of(context)
                          .push(EditTodoPage.route(initialTodo: todo));
                    },
                  )
              ],
            ));
          },
        ),
      ),
    );
  }
}
