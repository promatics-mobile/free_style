import 'package:flutter/material.dart';

class CustomSearchDropdown extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onSelected;

  const CustomSearchDropdown({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  State<CustomSearchDropdown> createState() =>
      _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (textEditingValue) {
        return widget.items.where((item) =>
            item.toLowerCase().contains(
              textEditingValue.text.toLowerCase(),
            ));
      },
      onSelected: widget.onSelected,
    );
  }
}