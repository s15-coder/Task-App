import 'package:flutter/material.dart';

Future showLoadingAlert(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      child: const AlertDialog(
        title: Text('Loading...'),
        content: LinearProgressIndicator(),
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
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
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
                  child: Text(
                    cancelText ?? 'Cancel',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
              TextButton(
                  onPressed: () =>
                      onOk != null ? onOk() : Navigator.pop(context, true),
                  child: Text(
                    okText ?? 'OK',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
          onWillPop: () async {
            Navigator.pop(context, false);
            return false;
          });
    },
  );
}
