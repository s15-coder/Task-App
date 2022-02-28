import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/bloc/user_bloc.dart';
import 'package:task_app/src/pages/login_page.dart';
import 'package:task_app/src/resources/db_hive.dart';
import 'package:task_app/src/widgets/card_container.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  static const String routeName = "ProfilePage";
  final user = HiveDB().getUser()!;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Tooltip(
        message: "Log Out",
        child: FloatingActionButton(
          onPressed: () async {
            final taskBloc = BlocProvider.of<TaskBloc>(context);
            await UserBloc().logOut(taskBloc);
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          },
          child: const Icon(Icons.logout),
        ),
      ),
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: CardContainer(
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileProperty(
                            keyString: 'Name',
                            value: user.name,
                          ),
                          const Divider(),
                          ProfileProperty(
                            keyString: 'Email',
                            value: user.email,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: const CircleAvatar(
                    maxRadius: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileProperty extends StatelessWidget {
  const ProfileProperty({
    Key? key,
    required this.keyString,
    required this.value,
  }) : super(key: key);
  final String keyString;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "$keyString:",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
