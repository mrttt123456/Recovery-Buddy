import 'package:flutter/material.dart';

class CommunityPostCard extends StatelessWidget {
  final String userName;
  final String postContent;

  CommunityPostCard({required this.userName, required this.postContent});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(userName[0].toUpperCase())),
        title: Text(userName),
        subtitle: Text(postContent),
      ),
    );
  }
}
