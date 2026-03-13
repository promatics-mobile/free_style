import 'dart:async';
import 'package:flutter/material.dart';
import '../../main.dart';

class NetworkBanner {

  static OverlayEntry? _overlayEntry;

  static void show({
    required String message,
    required Color color,
  }) {

    final context = navigatorKey.currentContext;
    if (context == null) return;

    _overlayEntry!.remove();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Material(
            color: color,
            child: SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    Timer(const Duration(seconds: 2), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}