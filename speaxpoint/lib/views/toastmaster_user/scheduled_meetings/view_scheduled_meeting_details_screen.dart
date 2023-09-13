import 'package:flutter/material.dart';

class ViewScheduledMeetingDetailsScreen extends StatelessWidget {
  const ViewScheduledMeetingDetailsScreen({super.key, required this.chapterMeetingId});

  final String chapterMeetingId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(     
      body: Center(
        child: Text("View Scheduled Meeting Details Screen"),
      ),
    );
  }
}
