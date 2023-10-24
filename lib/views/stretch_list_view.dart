/*
Displays an overview of the user's stretching routine, 
progress, and any active recovery plans. 
Offers quick access to commonly used features and recently accessed content.
*/

import 'package:flutter/material.dart';
import 'package:RecoveryBuddy/models/stretch.dart';
import 'package:RecoveryBuddy/widgets/stretches_list.dart';

class StretchListView extends StatelessWidget {
  final List<Stretch> stretches;

  StretchListView({required this.stretches});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stretches'),
      ),
      // StretchesList widget needs to be defined in your code
      body: StretchesList(stretches: stretches),
    );
  }
}
