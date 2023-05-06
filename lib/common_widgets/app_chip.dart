import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final String label;
  final Icon? icon;

  const AppChip({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: icon,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      surfaceTintColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
