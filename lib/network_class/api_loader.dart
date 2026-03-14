import 'package:flutter/material.dart';
import 'package:free_style/utils/common_widgets/loaders/common_loader.dart';
import '../../main.dart';

class ApiLoader {
  static bool _isShowing = false;
  static BuildContext? _dialogContext;

  static void show() {
    if (_isShowing) return;
    final context = navigatorKey.currentContext;
    if (context == null) return;
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return const PopScope(
          canPop: false,
          child: Center(
            child: CommonLoader(),
          ),
        );
      },
    );
  }

  static void hide() {
    if (!_isShowing) return;
    _isShowing = false;
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!, rootNavigator: true).pop();
      _dialogContext = null;
    }
  }
}