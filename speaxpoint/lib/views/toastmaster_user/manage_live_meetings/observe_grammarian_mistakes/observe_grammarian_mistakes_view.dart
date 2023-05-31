import 'package:flutter/material.dart';

class ObserveGrammarianMistakesView extends StatefulWidget {
  const ObserveGrammarianMistakesView({
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
  State<ObserveGrammarianMistakesView> createState() =>
      _ObserveGrammarianMistakesScreenState();
}

class _ObserveGrammarianMistakesScreenState
    extends State<ObserveGrammarianMistakesView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Observe Grammarian Mistakes Screen"),
    );
  }
}