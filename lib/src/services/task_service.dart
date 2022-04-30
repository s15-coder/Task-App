import 'package:http/http.dart' as http;
import 'package:task_app/src/global/consts.dart';
import 'package:task_app/src/models/responses/get_tasks_response.dart';
import 'package:task_app/src/models/responses/save_task_response.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/resources/preferences.dart';

class TaskService {
  Future<Map<String, String>> _headers() async =>
      {'Authorization': PreferencesApp().getToken() ?? ''};
  Future<GetTasksResponse> getTasks() async {
    final response = await http.get(
      Uri.parse('$host/task/'),
      headers: await _headers(),
    );
    final getTasksResponse = getTasksResponseFromJson(response.body);
    return getTasksResponse;
  }

  Future<SaveTaskResponse> saveTask(Task newTask) async {
    final response = await http.post(Uri.parse('$host/task/new-task'),
        headers: await _headers(),
        body: {
          "description": newTask.description,
          "name": newTask.name,
          "state": newTask.state.nameState,
        });

    final saveTaskResponse = saveTaskResponseFromJson(response.body);
    return saveTaskResponse;
  }

  Future<SaveTaskResponse> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$host/task/update-task/?task_id=${task.id}'),
      headers: await _headers(),
      body: {
        "description": task.description,
        "name": task.name,
        "state": task.state.nameState,
      },
    );

    final saveTaskResponse = saveTaskResponseFromJson(response.body);
    return saveTaskResponse;
  }

  Future<SaveTaskResponse> deleteTask(String taskId) async {
    final response = await http.delete(Uri.parse('$host/task/delete-task'),
        headers: await _headers(),
        body: {
          "task_id": taskId,
        });

    final saveTaskResponse = saveTaskResponseFromJson(response.body);
    return saveTaskResponse;
  }
}
