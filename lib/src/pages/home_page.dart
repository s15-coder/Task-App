import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/global/consts.dart';
import 'package:task_app/src/pages/new_task_page.dart';
import 'package:task_app/src/pages/profile_page.dart';
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
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, NewTaskPage.routeName);
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, ProfilePage.routeName),
            icon: const Icon(Icons.settings),
          ),
          actions: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            PopupMenuButton(
                itemBuilder: (_) => [
                      PopupMenuItem<String>(
                        value: 'All',
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'All',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...defaultTasksTypes
                          .map((taskState) => PopupMenuItem<String>(
                                value: taskState.nameState,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      color: taskState.colorState,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      taskState.nameState,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList()
                    ]),
          ],
          title: const Text('HomePage'),
          centerTitle: true,
        ),
        body: const TasksList());
  }
}

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TaskBloc, TaskStateBloc>(
      builder: (context, state) {
        if (state.loading && state.tasks.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!state.loading && state.tasks.isEmpty) {
          return Center(
            child: Container(
              height: 150,
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    FontAwesomeIcons.tasks,
                    size: 30,
                  ),
                  Text(
                    'Create new tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: SizedBox(
            height: size.height,
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
