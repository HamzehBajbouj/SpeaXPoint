import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/services/failure.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class GrammaticalNoteBottomSheet extends StatefulWidget {
  const GrammaticalNoteBottomSheet({
    super.key,
    required this.grammaticalNote,
    required this.isAGuest,
    required this.deleteNoteAction,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final GrammarianNote grammaticalNote;
  final bool isAGuest;
  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;
  final Future<Result<Unit, Failure>> Function({
    required bool currentSpeakerisAppGuest,
    required String noteId,
    String? chapterMeetingId,
    String? currentSpeakerToastmasterId,
    String? currentSpeakerGuestInvitationCode,
    String? chapterMeetingInvitationCode,
  }) deleteNoteAction;

  // required String noteId,
  // required bool currentSpeakerisAppGuest,
  // String? currentSpeakerToastmasterId,
  // String? currentSpeakerGuestInvitationCode,
  // String? chapterMeetingInvitationCode,
  // String? chapterMeetingId,
  @override
  State<GrammaticalNoteBottomSheet> createState() =>
      _EvaluationNoteBottomSheetState();
}

class _EvaluationNoteBottomSheetState
    extends State<GrammaticalNoteBottomSheet> {
  bool _showErrorMessage = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
        child: _isLoading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(
                    color: Color(AppMainColors.p40),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Deleting The Note...',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.grammaticalNote.noteTitle == null ||
                                widget.grammaticalNote.noteTitle!.isEmpty
                            ? "Note Content"
                            : widget.grammaticalNote.noteTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Color(AppMainColors.p90),
                        ),
                      ),
                      textButton(
                        callBack: () {
                          Navigator.pop(context);
                        },
                        content: const Text(
                          "Close",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Text(
                          widget.grammaticalNote.noteContent!,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.p50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  outlinedButton(
                    callBack: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await widget
                          .deleteNoteAction(
                        currentSpeakerisAppGuest: widget.isAGuest,
                        noteId: widget.grammaticalNote.noteId!,
                        chapterMeetingId: widget.chapterMeetingId,
                        chapterMeetingInvitationCode:
                            widget.chapterMeetingInvitationCode,
                        currentSpeakerGuestInvitationCode:
                            widget.guestInvitationCode,
                        currentSpeakerToastmasterId: widget.toastmasterId,
                      )
                          .then(
                        (value) {
                          value.when(
                            (success) {
                              setState(
                                () {
                                  _showErrorMessage = false;
                                },
                              );
                              Navigator.of(context).pop(true);
                            },
                            (error) {
                              setState(
                                () {
                                  _showErrorMessage = true;
                                  _isLoading = false;
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    content: "Delete Evaluation Note",
                    buttonColor: const Color(AppMainColors.warningError50),
                  ),
                  Visibility(
                    visible: _showErrorMessage,
                    child: const Text(
                      "An error occured while deleting the grammatical note, please try again..",
                      style: TextStyle(
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
      ),
    );
  }
}
