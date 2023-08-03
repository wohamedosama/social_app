import 'package:flutter/material.dart';

class NavigateTo {
  static void navigateTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );

  static void navigateAndReplacement(context, widget) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ),
          (route) => false);
}
