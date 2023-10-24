/*
Displays an overview of the user's stretching routine, 
progress, and any active recovery plans. 
Offers quick access to commonly used features and recently accessed content.
*/

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stretch Safe'),
      ),
      // StretchesList widget needs to be defined in your code
      body: null,
    );
  }
}
