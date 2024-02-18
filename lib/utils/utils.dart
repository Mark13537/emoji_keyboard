import 'package:flutter/material.dart';

class Utils {
  static ScaffoldFeatureController showInSnackBar(
      final BuildContext context, final String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
