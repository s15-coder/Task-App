part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTasksEvent extends TaskEvent {
  final List<Task> tasks;

  const UpdateTasksEvent(this.tasks);
}

class StartFetchingTasksEvent extends TaskEvent {}

class StopFetchingTasksEvent extends TaskEvent {}

class UpdateNewTaskTypeEvent extends TaskEvent {
  final TaskType taskTypeModel;
  const UpdateNewTaskTypeEvent(this.taskTypeModel);
}

class ResetNewTaskTypeEvent extends TaskEvent {}

class ClearBlocEvent extends TaskEvent {}

class ChangeTaskFilterEvent extends TaskEvent {
  final String typeTaskName;
  const ChangeTaskFilterEvent(this.typeTaskName);
}

class ResetFilterEvent extends TaskEvent {}
