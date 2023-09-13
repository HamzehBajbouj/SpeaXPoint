import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_chapter_meeting_announcement_view_model.dart';

class AddMeetingToScheduledMeetingsDialog extends StatefulWidget {
  const AddMeetingToScheduledMeetingsDialog({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  final String chapterMeetingId;
  final String clubId;
  @override
  State<AddMeetingToScheduledMeetingsDialog> createState() =>
      _AddMeetingToScheduledMeetingsDialogState();
}

class _AddMeetingToScheduledMeetingsDialogState
    extends State<AddMeetingToScheduledMeetingsDialog> {
  late ManageChapterMeetingAnnouncementViewModel manageAnnouncementVM;

  bool _showErrorMessage = false;
  bool _isLoading = false;
  String _messageError =
      "An error occured while adding the session, please try again..";
  @override
  void initState() {
    super.initState();
    manageAnnouncementVM =
        Provider.of<ManageChapterMeetingAnnouncementViewModel>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _isLoading
          ? null
          : Text(
              _showErrorMessage ? "Error!" : 'Warning !',
              style: const TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.warningError75),
              ),
            ),
      content: _isLoading
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  color: Color(AppMainColors.p40),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Adding The Meeting To Scheduled Meetings...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.4,
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(AppMainColors.p70),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: !_showErrorMessage,
                  child: const Text(
                    "Are you sure you want to add the meeting session to the scheduled meetings?",
                    style: TextStyle(
                      height: 1.4,
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p70),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: _showErrorMessage,
                  child: Text(
                    _messageError,
                    style: const TextStyle(
                      height: 1.4,
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.warningError75),
                    ),
                  ),
                ),
              ],
            ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Visibility(
          visible: !_isLoading,
          child: textButton(
            callBack: () {
              Navigator.of(context).pop(false);
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
        ),
        Visibility(
          visible: !_isLoading,
          child: filledTextButton(
              callBack: () async {
                setState(() {
                  _isLoading = true;
                });
                await manageAnnouncementVM
                    .addMeetingToSchedule(
                        chapterMeetingId: widget.chapterMeetingId,
                        clubId: widget.clubId)
                    .then(
                  (value) {
                    value.when(
                      (success) {
                        setState(
                          () {
                            _showErrorMessage = false;
                          },
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(
                            text: const Text(
                              "Meeting Has Been Scheduled Successfully.",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(AppMainColors.p80),
                              ),
                            ),
                            color: const Color(
                                AppMainColors.successSnapBarMessage),
                          ),
                        );
                        Navigator.of(context).pop(true);
                      },
                      (error) {
                        setState(
                          () {
                            if (error.code == "Meeting-Visitor-Id-Is-Existed") {
                              _messageError = error.message;
                            }
                            _showErrorMessage = true;
                            _isLoading = false;
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
        ),
      ],
    );
  }
}
