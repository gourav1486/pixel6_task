import 'package:flutter/material.dart';
void showCustomSnackbar(BuildContext context, String message,Color color) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color, // Customize the background color as needed
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}