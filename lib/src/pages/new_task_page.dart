import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/global/consts.dart';
import 'package:task_app/src/helpers/alerts.dart';
import 'package:task_app/src/helpers/validations_fields.dart';
import 'package:task_app/src/models/task.dart';
import 'package:task_app/src/models/task_type.dart';
import 'package:task_app/src/pages/home_page.dart';
import 'package:task_app/src/widgets/card_container.dart';
import 'package:task_app/src/widgets/custom_field.dart';

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
        title: const Text('New Task'),
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
                  hintText: 'Task\'s name',
                  textCapitalization: TextCapitalization.sentences,
                  prefixIcon: Icons.check_circle_outline,
                  controller: ctrlNameTask,
                  onSubmitted: (v) => focusNodeDesc.requestFocus(),
                  validator: (value) {
                    return ValidationsFields().validateFields([
                      Field(value: value, fieldName: 'Task name', minLenght: 4),
                    ]);
                  },
                ),
                const Divider(),
                CustomTextField(
                  hintText: 'Task\'s description',
                  prefixIcon: FontAwesomeIcons.tasks,
                  controller: ctrlDescriptionTask,
                  focusNode: focusNodeDesc,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    return ValidationsFields().validateFields([
                      Field(
                        value: value,
                        fieldName: 'Task Description',
                        minLenght: 4,
                      ),
                    ]);
                  },
                ),
                const Divider(),
                const _CustomDropDownBottom(),
                const Divider(),
                SaveUpdateButton(
                  label: edit ? "Edit" : "Save",
                  onPressed: () async {
                    //Validate text fields.
                    final validFields = _formKey.currentState!.validate();
                    if (!validFields) return;

                    final taskBloc = BlocProvider.of<TaskBloc>(context);
                    if (taskBloc.taskState == null) {
                      return showMessageAlert(
                        context: context,
                        title: 'Verify',
                        message: 'Select the state of the task',
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

  Future onSave(Task newTask) async {
    showLoadingAlert(context);
    final response = await taskBloc.saveTask(newTask);
    Navigator.pop(context);
    if (response.ok) {
      return showMessageAlert(
          context: context,
          title: 'Success',
          message: response.msg,
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
      title: 'Error',
      message: response.msg,
    );
  }

  Future onEdit(Task task) async {
    task.id = taskBloc.editTask!.id;
    showLoadingAlert(context);
    final response = await taskBloc.updateTask(task);
    Navigator.pop(context);
    if (response.ok) {
      return showMessageAlert(
          context: context,
          title: 'Success',
          message: response.msg,
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
          const Text(
            'Select the task\'s state',
            style: TextStyle(
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
                      taskState.nameState,
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
            value as TaskType,
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
