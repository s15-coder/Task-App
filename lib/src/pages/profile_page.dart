import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/src/bloc/task/task_bloc.dart';
import 'package:task_app/src/bloc/theme/theme_bloc.dart';
import 'package:task_app/src/bloc/user/user_bloc.dart';
import 'package:task_app/src/models/user_hive.dart';
import 'package:task_app/src/resources/db_hive.dart';
import 'package:task_app/src/widgets/card_container.dart';
import 'package:task_app/src/widgets/right_banner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  static const String routeName = "ProfilePage";
  final user = HiveDB().getUser()!;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            ProfileInfo(user: user),
            Positioned(
              bottom: size.height * 0.25,
              right: 0,
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return RightBanner(
                    prefixBanner: Container(
                      child: const Icon(
                        FontAwesomeIcons.sun,
                        color: Colors.green,
                      ),
                      margin: const EdgeInsets.only(right: 6),
                    ),
                    label: state.themeMode == ThemeMode.dark
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    onTap: () => BlocProvider.of<ThemeBloc>(context)
                        .toogleTheme(context),
                  );
                },
              ),
            ),
            Positioned(
              bottom: size.height * 0.15,
              right: 0,
              child: RightBanner(
                label: AppLocalizations.of(context)!.sign_off,
                onTap: () async {
                  final taskBloc = BlocProvider.of<TaskBloc>(context);
                  final userBloc = BlocProvider.of<UserBloc>(context);
                  await userBloc.logOut(taskBloc, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
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
                      _ProfileProperty(
                        keyString: AppLocalizations.of(context)!.name,
                        value: user.name,
                      ),
                      const Divider(),
                      _ProfileProperty(
                        keyString: AppLocalizations.of(context)!.email,
                        value: user.email,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                maxRadius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: user.picture != null
                        ? Image.network(user.picture!)
                        : Transform.translate(
                            offset: const Offset(-15, -10),
                            child: Icon(
                              Icons.person,
                              size: 120,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileProperty extends StatelessWidget {
  const _ProfileProperty({
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
            flex: 1,
            child: Text(
              value,
              maxLines: 3,
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
