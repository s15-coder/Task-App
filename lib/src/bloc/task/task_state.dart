part of 'task_bloc.dart';

class TaskStateBloc extends Equatable {
  const TaskStateBloc({
    this.tasks = const [],
    this.loading = false,
  });
  final List<Task> tasks;
  final bool loading;

  TaskStateBloc copyWith({
    List<Task>? tasks,
    bool? loading,
  }) =>
      TaskStateBloc(
        tasks: tasks ?? this.tasks,
        loading: loading ?? this.loading,
      );
  @override
  List<Object> get props => [
        tasks,
        loading,
      ];
}
