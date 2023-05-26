import 'package:flutter/material.dart';

class ManageEvaluationView extends StatefulWidget {
  const ManageEvaluationView({
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
  State<ManageEvaluationView> createState() => _ManageEvaluationViewState();
}

class _ManageEvaluationViewState extends State<ManageEvaluationView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Manage Evaluation Screen"),
    );
  }
}
