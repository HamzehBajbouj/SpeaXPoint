import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
