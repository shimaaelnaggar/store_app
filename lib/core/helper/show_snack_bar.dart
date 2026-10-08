import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String message,
    required Color backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 2),
  ));
}
