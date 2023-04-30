import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/volunteer_announcement_view_details_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/dialogs/volunteer_to_role_slot_completion_message.dialog.dart';

class VolunteerToRoleSlotConfirmationDialog extends StatefulWidget {
  const VolunteerToRoleSlotConfirmationDialog({
    super.key,
    required this.chapterMeetingId,
    required this.slotUnqiueId,
  });
  final String chapterMeetingId;
  final int slotUnqiueId;
  @override
  State<VolunteerToRoleSlotConfirmationDialog> createState() =>
      _VolunteerToRoleSlotConfirmationDialogState();
}

class _VolunteerToRoleSlotConfirmationDialogState
    extends State<VolunteerToRoleSlotConfirmationDialog> {
  late VolunteerAnnouncementViewDetailsViewModel
      _volunteerAnnouncementViewDetailsViewModel;
  @override
  void initState() {
    super.initState();
    _volunteerAnnouncementViewDetailsViewModel =
        Provider.of<VolunteerAnnouncementViewDetailsViewModel>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Confirm',
        style: TextStyle(
          fontFamily: CommonUIProperties.fontType,
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Color(AppMainColors.p80),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Are you sure that you want to volunteer for this role?",
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
              _volunteerAnnouncementViewDetailsViewModel
                  .volunteerToRoleSlot(
                chapterMeetingId: widget.chapterMeetingId,
                slotUnqiueId: widget.slotUnqiueId,
              )
                  .then(
                (value) {
                  value.whenSuccess(
                    (_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const VolunteerToRoleSlotCompletionMessageDialog(
                            isWarningMessage: false,
                            message:
                                "You have successfully applied for this role."
                                "It will be added to your meeting schedules once the VPE accept your application.",
                          );
                        },
                      ).then(
                        (value) {
                          Navigator.of(context).pop();
                        },
                      );
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
