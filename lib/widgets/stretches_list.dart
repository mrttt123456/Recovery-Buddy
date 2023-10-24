import 'package:RecoveryBuddy/widgets/feed_timeline.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:RecoveryBuddy/models/stretch.dart';

class StretchesList extends StatelessWidget {
  final List<Stretch> stretches;

  StretchesList({required this.stretches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stretches.length,
      itemBuilder: (context, index) {
        final stretch = stretches[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListTile(
                leading:
                    (stretch.imageUrl != null && stretch.imageUrl!.isNotEmpty)
                        ? Image.asset(stretch.imageUrl!)
                        : null,
                title: Text(stretch.name),
//                subtitle: Text(stretch.muscleGroup),
                onTap: () async {
                  // Open YouTube link
                  if (await canLaunchUrl(Uri.parse(stretch.youtubeLink))) {
                    await launchUrl(Uri.parse(stretch.youtubeLink));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Could not open YouTube link.')));
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => ComposeActivityPage(
                            preFilledText:
                                "I have completed " + stretch.name + "!",
                          )),
                );
                // Call your compose post UI code here
              },
              child: Text('Complete'),
            ),
          ],
        );
      },
    );
  }
}
