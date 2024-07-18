import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> navigateTo<T>(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<T?> navigateAndReplace<T>(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
