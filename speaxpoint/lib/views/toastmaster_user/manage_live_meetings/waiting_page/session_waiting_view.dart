import 'package:flutter/material.dart';

class SessionWaitingView extends StatefulWidget {
  const SessionWaitingView({
    super.key,
    this.chapterMeetingId,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;

  @override
  State<SessionWaitingView> createState() => _SessionWaitingScreenState();
}

class _SessionWaitingScreenState extends State<SessionWaitingView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Waiting screen"),
    );
  }
}
