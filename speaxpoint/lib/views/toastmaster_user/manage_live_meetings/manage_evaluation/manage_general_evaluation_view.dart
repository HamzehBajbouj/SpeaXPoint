import 'package:flutter/material.dart';

class ManageGeneralEvaluationView extends StatefulWidget {
  const ManageGeneralEvaluationView({
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
  State<ManageGeneralEvaluationView> createState() => _ManageSpeechEvaluationViewState();
}

class _ManageSpeechEvaluationViewState extends State<ManageGeneralEvaluationView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Manage General Evaluation Screen"),
    );
  }
}
