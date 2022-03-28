part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState(
      {this.tasks = const [], this.loading = false, this.typeTaskFilter = ''});
  final List<Task> tasks;
  final bool loading;
  final String typeTaskFilter;
  TaskState copyWith(
          {List<Task>? tasks, bool? loading, String? typeTaskFilter}) =>
      TaskState(
        tasks: tasks ?? this.tasks,
        loading: loading ?? this.loading,
        typeTaskFilter: typeTaskFilter ?? this.typeTaskFilter,
      );
  @override
  List<Object?> get props => [tasks, loading, typeTaskFilter];
}
