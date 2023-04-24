import 'package:flutter/material.dart';

class ChapterMeetingAnnouncementViewScreen extends StatefulWidget {
  const ChapterMeetingAnnouncementViewScreen({super.key});

  @override
  State<ChapterMeetingAnnouncementViewScreen> createState() =>
      _ChapterMeetingAnnouncementViewScreenState();
}

class _ChapterMeetingAnnouncementViewScreenState
    extends State<ChapterMeetingAnnouncementViewScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("View Announcement"),),
    );
  }
}
