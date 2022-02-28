part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTasks extends TaskEvent {
  final List<Task> tasks;

  const AddTasks(this.tasks);
}

class StartFetchingTasks extends TaskEvent {}

class StopFetchingTasks extends TaskEvent {}

class UpdateNewTaskState extends TaskEvent {
  final TaskType taskStateModel;

  const UpdateNewTaskState(this.taskStateModel);
}

class ResetNewTaskState extends TaskEvent {}

class ClearBloc extends TaskEvent {}
