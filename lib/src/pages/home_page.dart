import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/pages/new_task_page.dart';
import 'package:task_app/src/widgets/app_bar_home.dart';
import 'package:task_app/src/widgets/no_tasks_widget.dart';
import 'package:task_app/src/widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, NewTaskPage.routeName);
        },
      ),
      appBar: const AppBarHome(),
      body: const TasksList(),
    );
  }
}

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.loading && state.tasks.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!state.loading && state.tasks.isEmpty) {
          return const NoTasksWidget();
        }
        if (state.typeTaskFilter.isNotEmpty) {
          return SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ...state.tasks
                      .where((task) =>
                          task.state.nameState == state.typeTaskFilter)
                      .map((task) => TaskItem(task: task))
                ],
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ...state.tasks.map((task) => TaskItem(task: task))
              ],
            ),
          ),
        );
      },
    );
  }
}
