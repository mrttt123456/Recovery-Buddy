import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final IconData icon;
  final String label;

  Badge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 48),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
