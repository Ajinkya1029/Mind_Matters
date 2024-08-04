import 'package:flutter/material.dart';
import 'package:mind_matters/main.dart';
class SnackbarUtils {
  static void showSnackBar(String message) {
    final scaffoldMessenger = MyApp.scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {
      final context = scaffoldMessenger.context;
      final backgroundColor = Color.fromRGBO(178, 216, 216, 1);
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
      ));
    }
  }
}
