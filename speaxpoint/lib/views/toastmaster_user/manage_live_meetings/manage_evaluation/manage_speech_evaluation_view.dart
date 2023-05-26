import 'package:flutter/material.dart';

class ManageSpeechEvaluationView extends StatefulWidget {
  const ManageSpeechEvaluationView({
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
  State<ManageSpeechEvaluationView> createState() => _ManageSpeechEvaluationViewState();
}

class _ManageSpeechEvaluationViewState extends State<ManageSpeechEvaluationView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Manage Speech Evaluation Screen"),
    );
  }
}
