import 'package:flutter/material.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/count_time_fillers/time_filler_counter_.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/count_time_fillers/time_filler_notes.dart';

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeFillerCounter(),
                TimeFillerCounter(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeFillerCounter(),
                TimeFillerCounter(),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TimeFillerNotes(
              isAGuest: widget.isAGuest,
              guestInvitationCode: widget.guestInvitationCode,
              chapterMeetingId: widget.chapterMeetingId,
              toastmasterId: widget.toastmasterId,
              chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            ),
          ],
        ),
      ),
    );
  }

  // Widget getTest() {
  //   return
  // }
}
