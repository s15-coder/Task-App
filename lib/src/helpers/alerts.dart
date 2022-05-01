import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future showLoadingAlert(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.loading),
        content: const LinearProgressIndicator(),
      ),
      onWillPop: () async => false,
    ),
  );
}

Future showMessageAlert({
  required BuildContext context,
  required String title,
  required String message,
  bool closeOnBackArrow = true,
  VoidCallback? onOk,
}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
        child: AlertDialog(
          content: Text(message),
          title: Text(title),
          actions: [
            TextButton(
                onPressed: () => onOk != null ? onOk() : Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.ok,
                ))
          ],
        ),
        onWillPop: () async => closeOnBackArrow),
  );
}

Future<bool?> confirmAlert({
  required BuildContext context,
  required String title,
  required String message,
  VoidCallback? onOk,
  String? okText,
  VoidCallback? onCancel,
  String? cancelText,
}) async {
  return await showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return WillPopScope(
          child: AlertDialog(
            content: Text(message),
            title: Text(title),
            actions: [
              TextButton(
                  onPressed: () =>
                      onOk != null ? onOk() : Navigator.pop(context, false),
                  child:
                      Text(cancelText ?? AppLocalizations.of(context)!.cancel)),
              TextButton(
                  onPressed: () =>
                      onOk != null ? onOk() : Navigator.pop(context, true),
                  child: Text(okText ?? AppLocalizations.of(context)!.ok)),
            ],
          ),
          onWillPop: () async {
            Navigator.pop(context, false);
            return false;
          });
    },
  );
}
