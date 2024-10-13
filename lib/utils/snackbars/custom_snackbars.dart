import 'package:flutter/material.dart';

class AppCustomSnackBars {
 static normalSuccess(context, {content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
