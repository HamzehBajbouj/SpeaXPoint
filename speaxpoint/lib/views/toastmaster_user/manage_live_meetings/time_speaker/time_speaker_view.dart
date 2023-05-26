import 'package:flutter/material.dart';

class TimeSpeakerView extends StatefulWidget {
  const TimeSpeakerView({
    super.key,
    this.chapterMeetingId,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
    this.guestHasRole,
    this.guestInvitationCode,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final bool? guestHasRole;
  final String? guestInvitationCode;

  @override
  State<TimeSpeakerView> createState() => _TimeSpeakerScreenState();
}

class _TimeSpeakerScreenState extends State<TimeSpeakerView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Time Speaker Screen"),
    );
  }
}
