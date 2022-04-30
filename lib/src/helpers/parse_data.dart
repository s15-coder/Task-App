import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParseData {
  static final ParseData _instance = ParseData._privateConstructor();
  factory ParseData() => _instance;
  ParseData._privateConstructor();

  String stateToText(String state, BuildContext context) {
    switch (state) {
      case "To Do":
        return AppLocalizations.of(context)!.to_do;
      case "Doing":
        return AppLocalizations.of(context)!.doing;
      case "Done":
        return AppLocalizations.of(context)!.done;
      default:
        return AppLocalizations.of(context)!.all_tasks;
    }
  }
}
