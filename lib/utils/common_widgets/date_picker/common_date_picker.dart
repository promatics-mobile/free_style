import 'package:flutter/material.dart';

class CommonDatePicker {
  static Future<DateTime?> pickFutureDate(BuildContext context) {
    return showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }

  static Future<DateTime?> pickPastDate(BuildContext context) {
    return showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
  }
}