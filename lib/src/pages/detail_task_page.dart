import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/pages/new_task_page.dart';
import 'package:task_app/src/pages/stadium_button.dart';
import 'package:task_app/src/widgets/card_container.dart';

class DetailTaskPage extends StatelessWidget {
  const DetailTaskPage({Key? key}) : super(key: key);
  static const String routeName = "DetailTaskPage";
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    final task = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CardContainer(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task.name,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(task.description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      )),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        color: task.state.colorState,
                      ),
                      const SizedBox(width: 10),
                      Text(task.state.nameState),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          StadiumButton(
            onPressed: () {
              taskBloc.editTask = task;
              Navigator.pushNamed(context, NewTaskPage.routeName);
            },
            text: "Edit",
          ),
          const SizedBox(
            height: 10,
          ),
          StadiumButton(
            onPressed: () async {
              bool? delete = await confirmAlert(
                context: context,
                title: "Delete",
                message: "Do you want delete this task forever?",
              );
              if (delete ?? false) {
                showLoadingAlert(context);
                final response = await taskBloc.deleteTask(task.id);
                Navigator.pop(context);
                if (response.ok) {
                  return showMessageAlert(
                    closeOnBackArrow: false,
                    context: context,
                    title: 'Success',
                    message: 'Task deleted successfully.',
                    onOk: () {
                      //Close alert
                      Navigator.pop(context);
                      //Cloase detail
                      Navigator.pop(context);
                    },
                  );
                }
                return showMessageAlert(
                  context: context,
                  title: 'Problem',
                  message: response.msg,
                );
              }
            },
            text: "Delete",
          ),
        ],
      ),
    );
  }
}
