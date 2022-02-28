import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:task_app/src/helpers/alerts.dart';

class NewtworkValidator {
  static final NewtworkValidator _instance =
      NewtworkValidator._privateConstructor();
  factory NewtworkValidator() => _instance;
  NewtworkValidator._privateConstructor();

  static Future<bool> checkNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> checkNetworkAndAlert(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      throw '';
    } catch (_) {
      showMessageAlert(
        context: context,
        title: 'Connection',
        message: 'Verify you network connection',
      );
      return false;
    }
  }
}
