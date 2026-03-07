import 'package:flutter/material.dart';

class CommonTimePicker {
  static Future<String?> pick(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked == null) return null;

    return "${picked.hour.toString().padLeft(2, '0')}:"
        "${picked.minute.toString().padLeft(2, '0')}:00";
  }
}