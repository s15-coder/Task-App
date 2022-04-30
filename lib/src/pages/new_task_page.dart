import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/global/consts.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/helpers/parse_data.dart';
import 'package:task_app/src/helpers/validations_fields.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/models/task_type.dart';
import 'package:task_app/src/widgets/card_container.dart';
import 'package:task_app/src/widgets/custom_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);
  static const String routeName = "NewTaskPage";

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final ctrlNameTask = TextEditingController();
  final ctrlDescriptionTask = TextEditingController();
  final focusNodeDesc = FocusNode();

  late final bool edit;

  final _formKey = GlobalKey<FormState>();

  late final TaskBloc taskBloc;
  @override
  void initState() {
    super.initState();
    taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.add(ResetNewTaskTypeEvent());
    final editTask = taskBloc.editTask;
    edit = editTask != null;
    if (edit) {
      taskBloc.add(UpdateNewTaskTypeEvent(editTask!.state));
      ctrlNameTask.text = editTask.name;
      ctrlDescriptionTask.text = editTask.description;
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskBloc.editTask = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.new_task),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: CardContainer(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.task_name,
                  textCapitalization: TextCapitalization.sentences,
                  prefixIcon: Icons.check_circle_outline,
                  controller: ctrlNameTask,
                  onSubmitted: (v) => focusNodeDesc.requestFocus(),
                  validator: (value) {
                    return ValidationsFields().validateFields([
                      Field(
                        value: value,
                        fieldName: AppLocalizations.of(context)!.task_name,
                        minLenght: 4,
                      ),
                    ]);
                  },
                ),
                const Divider(),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.task_description,
                  prefixIcon: FontAwesomeIcons.tasks,
                  controller: ctrlDescriptionTask,
                  focusNode: focusNodeDesc,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    return ValidationsFields().validateFields([
                      Field(
                        value: value,
                        fieldName:
                            AppLocalizations.of(context)!.task_description,
                        minLenght: 4,
                      ),
                    ]);
                  },
                ),
                const Divider(),
                const _CustomDropDownBottom(),
                const Divider(),
                SaveUpdateButton(
                  label: edit
                      ? AppLocalizations.of(context)!.edit
                      : AppLocalizations.of(context)!.save,
                  onPressed: () async {
                    //Validate text fields.
                    final validFields = _formKey.currentState!.validate();
                    if (!validFields) return;

                    final taskBloc = BlocProvider.of<TaskBloc>(context);
                    if (taskBloc.taskState == null) {
                      return showMessageAlert(
                        context: context,
                        title: 'Verify',
                        message:
                            AppLocalizations.of(context)!.select_task_state,
                      );
                    }

                    //The task to be saved on the server
                    final newTask = Task(
                      name: ctrlNameTask.value.text,
                      description: ctrlDescriptionTask.value.text,
                      id: '',
                      state: taskBloc.taskState!,
                    );
                    if (edit) {
                      await onEdit(newTask);
                    } else {
                      await onSave(newTask);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future onSave(Task newTask) async =>
      await taskBloc.saveTask(newTask, context);

  Future onEdit(Task task) async {
    task.id = taskBloc.editTask!.id;
    await taskBloc.updateTask(task, context);
  }
}

class _CustomDropDownBottom extends StatelessWidget {
  const _CustomDropDownBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    return DropdownButtonFormField2<TaskType?>(
      value: taskBloc.editTask != null ? taskBloc.editTask!.state : null,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.yellow,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      isExpanded: true,
      hint: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(
            AppLocalizations.of(context)!.select_task_state,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: defaultTasksTypes
          .map((taskState) => DropdownMenuItem<TaskType?>(
                value: taskState,
                child: Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      color: taskState.colorState,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      ParseData().stateToText(
                        taskState.nameState,
                        context,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        final taskBloc = BlocProvider.of<TaskBloc>(context);
        return taskBloc.add(
          UpdateNewTaskTypeEvent(
            value,
          ),
        );
      },
    );
  }
}

class SaveUpdateButton extends StatelessWidget {
  const SaveUpdateButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final void Function()? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 8,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
