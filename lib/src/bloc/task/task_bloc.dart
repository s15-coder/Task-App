import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/models/responses/save_task_response.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/models/task_type.dart';
import 'package:task_app/src/services/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskStateBloc> {
  TaskType? _taskStateModel;
  final TaskService _taskService = TaskService();
  TaskBloc() : super(const TaskStateBloc()) {
    on<AddTasks>(
      (event, emit) => emit(state.copyWith(tasks: event.tasks)),
    );
    on<StartFetchingTasks>(
      (event, emit) => emit(state.copyWith(loading: true)),
    );
    on<StopFetchingTasks>(
      (event, emit) => emit(state.copyWith(loading: false)),
    );
    on<UpdateNewTaskState>(
      (event, emit) => _taskStateModel = event.taskStateModel,
    );
    on<ClearBloc>(
      (event, emit) => emit(const TaskStateBloc()),
    );
    on<ResetNewTaskState>(
      (event, emit) => _taskStateModel = null,
    );
  }
  TaskType? get taskState => _taskStateModel;

  Future getTasks() async {
    add(StartFetchingTasks());
    final getTasksResponse = await _taskService.getTasks();
    if (getTasksResponse.ok) {
      add(AddTasks(getTasksResponse.tasks));
    }
    add(StopFetchingTasks());
  }

  Future<SaveTaskResponse> saveTask(Task newTask) async {
    final response = await _taskService.saveTask(newTask);
    if (response.ok) {
      final tasks = [
        response.createdTask!,
        ...state.tasks,
      ];
      add(AddTasks(tasks));
    }
    return response;
  }

  ///Clears all data stored in bloc and it's state
  void clearBloc() {
    add(ClearBloc());
    _taskStateModel = null;
  }
}
