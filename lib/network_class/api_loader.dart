import 'package:flutter/material.dart';

import '../../main.dart';
import '../utils/common_constants.dart';

class ApiLoader {
  static bool _isShowing = false;

  static void show() {
    if (_isShowing) return;
    _isShowing = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: Center(
              child: CircularProgressIndicator(
                color: CommonColors.secondaryColor,
              ),
            ),
          );
        },
      );
    });

  }

  static void hide() {
    if (!_isShowing) return;
    _isShowing = false;
    Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
  }

}
