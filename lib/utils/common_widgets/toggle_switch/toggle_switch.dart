import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common_constants.dart';

class CommonToggleSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;
  final bool enabled;

  const CommonToggleSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.icon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = CommonColors.themeColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, color: activeColor),
            if (icon != null) const SizedBox(width: 8),
            Text(label),
          ],
        ),
        Switch(
          value: value,
          onChanged: enabled ? onChanged : null,
          activeColor: activeColor,
        ),
      ],
    );
  }
}