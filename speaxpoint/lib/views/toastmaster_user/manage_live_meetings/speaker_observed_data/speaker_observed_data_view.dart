import 'package:flutter/material.dart';

class SpeakerObservedDataViwe extends StatefulWidget {
  const SpeakerObservedDataViwe({
    super.key,
    this.chapterMeetingId,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<SpeakerObservedDataViwe> createState() =>
      _SpeakerObservedDataScreenState();
}

class _SpeakerObservedDataScreenState extends State<SpeakerObservedDataViwe> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("speaker observed data screen"),
    );
  }
}
