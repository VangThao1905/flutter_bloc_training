import 'models/models.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
 class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  Stream<List<Todo>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }
}
