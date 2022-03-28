import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/src/models/responses/generic_response.dart';
import 'package:task_app/src/models/responses/save_task_response.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/models/task_type.dart';
import 'package:task_app/src/services/task_service.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskType? _taskStateModel;
  Task? editTask;
  final TaskService _taskService = TaskService();
  TaskBloc() : super(const TaskState()) {
    on<AddTasksEvent>(
      (event, emit) => emit(state.copyWith(tasks: event.tasks)),
    );
    on<StartFetchingTasksEvent>(
      (event, emit) => emit(state.copyWith(loading: true)),
    );
    on<StopFetchingTasksEvent>(
      (event, emit) => emit(state.copyWith(loading: false)),
    );
    on<UpdateNewTaskTypeEvent>(
      (event, emit) => _taskStateModel = event.taskTypeModel,
    );
    on<ClearBlocEvent>(
      (event, emit) => emit(const TaskState()),
    );
    on<ResetNewTaskTypeEvent>(
      (event, emit) => _taskStateModel = null,
    );
    on<ResetFilterEvent>((event, emit) => emit(state.copyWith(
          typeTaskFilter: '',
        )));
    on<ChangeTaskFilterEvent>((event, emit) => emit(state.copyWith(
          typeTaskFilter: event.typeTaskName,
        )));
  }
  TaskType? get taskState => _taskStateModel;

  Future getTasks() async {
    add(StartFetchingTasksEvent());
    final getTasksResponse = await _taskService.getTasks();
    if (getTasksResponse.ok) {
      add(AddTasksEvent(getTasksResponse.tasks));
    }
    add(StopFetchingTasksEvent());
  }

  Future<GenericResponse> updateTask(Task task) async {
    add(const AddTasksEvent([]));
    return await _taskService.updateTask(task);
  }

  Future<GenericResponse> deleteTask(String taskId) async {
    final response = await _taskService.deleteTask(taskId);
    if (response.ok) {
      final updatedTasks = [
        ...state.tasks.where((task) => task.id != taskId),
      ];
      add(AddTasksEvent(updatedTasks));
    }
    return response;
  }

  Future<SaveTaskResponse> saveTask(Task newTask) async {
    final response = await _taskService.saveTask(newTask);
    if (response.ok) {
      final tasks = [
        response.createdTask!,
        ...state.tasks,
      ];
      add(AddTasksEvent(tasks));
    }
    return response;
  }

  ///Clears all data stored in bloc and it's state
  void clearBloc() {
    add(ClearBlocEvent());
    _taskStateModel = null;
  }
}
