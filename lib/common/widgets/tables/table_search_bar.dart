import 'package:flutter/material.dart';

class TableSearchBar extends StatelessWidget {
  const TableSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: 50,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, right: 12),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            cursorHeight: 15,
            decoration: const InputDecoration(
              labelText: 'Search...',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
