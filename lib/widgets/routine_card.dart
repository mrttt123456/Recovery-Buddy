import 'package:flutter/material.dart';

class RoutineCard extends StatelessWidget {
  final String routineName;

  RoutineCard({required this.routineName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(routineName),
      ),
    );
  }
}
