import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_chapter_meeting_announcement_view_model.dart';

class AnnounceChapterConfirmationDialog extends StatefulWidget {
  const AnnounceChapterConfirmationDialog({
    super.key,
    required this.meetingDescription,
    required this.meetingTtile,
    required this.meetingDate,
    required this.annoucementLevel,
    required this.chapterMeetingId,
    required this.clubId,
    required this.contactNumber,
    required this.meetingStreamLink,
    this.brochureFile,
  });

  final String meetingDescription;
  final String meetingTtile;
  final String meetingDate;
  final String annoucementLevel;
  final String chapterMeetingId;
  final String clubId;
  final String contactNumber;
  final String meetingStreamLink;
  final File? brochureFile;

  @override
  State<AnnounceChapterConfirmationDialog> createState() =>
      _UpdateExitingRolePlayerDialogState();
}

class _UpdateExitingRolePlayerDialogState
    extends State<AnnounceChapterConfirmationDialog> {
  late ManageChapterMeetingAnnouncementViewModel _manageAnnouncementVM;

  @override
  void initState() {
    super.initState();
    _manageAnnouncementVM =
        Provider.of<ManageChapterMeetingAnnouncementViewModel>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Warning !',
        style: TextStyle(
          fontFamily: CommonUIProperties.fontType,
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Color(AppMainColors.warningError75),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Are you sure you want to announce the chaper meeting? this will result in deleting any existing volunteers query announcements.",
            style: TextStyle(
              height: 1.4,
              fontFamily: CommonUIProperties.fontType,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p70),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        textButton(
          callBack: () {
            Navigator.of(context).pop();
          },
          content: const Text(
            "Cancel",
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p50),
            ),
          ),
        ),
        filledTextButton(
            callBack: () async {
              await _manageAnnouncementVM
                  .announceChapterMeeting(
                meetingDescription: widget.meetingDescription,
                meetingTtile: widget.meetingTtile,
                meetingDate: widget.meetingDate,
                annoucementLevel: widget.annoucementLevel,
                chapterMeetingId: widget.chapterMeetingId,
                clubId: widget.clubId,
                contactNumber: widget.contactNumber,
                meetingStreamLink: widget.meetingStreamLink,
                brochureFile: widget.brochureFile,
              )
                  .then(
                (value) {
                  value.whenSuccess(
                    (_) async {
                      await _manageAnnouncementVM.deleteAnExistingAnnouncement(
                          chapterMeetingId: widget.chapterMeetingId,
                          announcementType:
                              AnnouncementType.VolunteersAnnouncement.name);
                      //return true to indicate that it have been announce successfully
                      Navigator.of(context).pop(true);
                    },
                  );
                },
              );
            },
            content: 'Confirm',
            buttonHeight: 40,
            buttonWidth: 90),
      ],
    );
  }
}
