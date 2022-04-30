import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/global/consts.dart';
import 'package:task_app/src/helpers/parse_data.dart';
import 'package:task_app/src/pages/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarHome extends StatefulWidget implements PreferredSizeWidget {
  const AppBarHome({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<AppBarHome> {
  _CustomAppBarState();
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);

    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pushNamed(
          context,
          ProfilePage.routeName,
        ),
        icon: const Icon(Icons.settings),
      ),
      actions: [
        // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        PopupMenuButton<String>(
          itemBuilder: (_) => [
            PopupMenuItem<String>(
              onTap: () {
                taskBloc.add(ResetFilterEvent());
              },
              value: AppLocalizations.of(context)!.all_tasks,
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.all_tasks,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ...defaultTasksTypes
                .map((taskState) => PopupMenuItem<String>(
                      onTap: () {
                        taskBloc
                            .add(ChangeTaskFilterEvent(taskState.nameState));
                      },
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
                            ParseData()
                                .stateToText(taskState.nameState, context),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList()
          ],
        ),
      ],
      title: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return Text(state.typeTaskFilter.isNotEmpty
              ? ParseData().stateToText(state.typeTaskFilter, context)
              : AppLocalizations.of(context)!.all_tasks);
        },
      ),
      centerTitle: true,
    );
  }
}
