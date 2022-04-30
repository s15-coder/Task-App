import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/models/task_type.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/services/task_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskType? _taskStateModel;
  Task? editTask;
  final TaskService _taskService = TaskService();
  TaskBloc() : super(const TaskState()) {
    on<UpdateTasksEvent>(
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
      add(UpdateTasksEvent(getTasksResponse.tasks));
    }
    add(StopFetchingTasksEvent());
  }

  Future updateTask(Task task, BuildContext context) async {
    showLoadingAlert(context);
    final response = await _taskService.updateTask(task);
    Navigator.pop(context);

    if (response.ok) {
      add(UpdateTasksEvent(response.tasks));

      return showMessageAlert(
          context: context,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.task_updated_succesfully,
          closeOnBackArrow: false,
          onOk: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.routeName,
              (route) => false,
            );
          });
    }
    return showMessageAlert(
      context: context,
      title: 'Error',
      message: response.msg,
    );
  }

  Future deleteTask(String taskId, BuildContext context) async {
    showLoadingAlert(context);

    final response = await _taskService.deleteTask(taskId);
    if (response.ok) {
      add(UpdateTasksEvent(response.tasks));
    }

    Navigator.pop(context);
    if (response.ok) {
      return showMessageAlert(
        closeOnBackArrow: false,
        context: context,
        title: AppLocalizations.of(context)!.success,
        message: AppLocalizations.of(context)!.task_deleted_succesfully,
        onOk: () {
          //Close alert
          Navigator.pop(context);
          //Close detail
          Navigator.pop(context);
        },
      );
    }
    return showMessageAlert(
      context: context,
      title: AppLocalizations.of(context)!.error,
      message: response.msg,
    );
  }

  Future saveTask(Task newTask, BuildContext context) async {
    showLoadingAlert(context);

    final response = await _taskService.saveTask(newTask);
    if (response.ok) {
      add(UpdateTasksEvent(response.tasks));
    }
    Navigator.pop(context);

    if (response.ok) {
      return showMessageAlert(
          context: context,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.task_created_succesfully,
          closeOnBackArrow: false,
          onOk: () {
            //Close alert
            Navigator.pop(context);
            //Close page
            Navigator.pop(context);
          });
    }
    return showMessageAlert(
      context: context,
      title: AppLocalizations.of(context)!.success,
      message: response.msg,
    );
  }

  ///Clears all data stored in bloc and it's state
  void clearBloc() {
    add(ClearBlocEvent());
    _taskStateModel = null;
  }
}
