import 'package:flutter/material.dart';

class StretchCard extends StatelessWidget {
  final String stretchName;
  final String imageUrl;

  StretchCard({required this.stretchName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(stretchName),
      ),
    );
  }
}
