import 'package:flutter/material.dart';

class CountTimeFillersView extends StatefulWidget {
  const CountTimeFillersView({
    super.key,
    this.chapterMeetingId,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
    this.guestHasRole,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final bool? guestHasRole;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<CountTimeFillersView> createState() => _CountTimeFillersViewState();
}

class _CountTimeFillersViewState extends State<CountTimeFillersView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Count Time Fillers Screen"),
    );
  }
}
