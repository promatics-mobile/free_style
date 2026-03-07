import 'package:flutter/material.dart';

class CommonDecorations {
  static BoxDecoration roundedCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  );
}