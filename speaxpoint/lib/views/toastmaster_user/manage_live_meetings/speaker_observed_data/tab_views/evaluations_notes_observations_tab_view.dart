import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/evaluation_notes/speech_evaluation_note.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/speech_observations_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/view_note_details_bottom_sheet.dart';

class EvaluationNotesObservationsTabView extends StatefulWidget {
  const EvaluationNotesObservationsTabView(
      {super.key,
      required this.isAGuest,
      this.chapterMeetingId,
      this.chapterMeetingInvitationCode,
      this.guestInvitationCode,
      this.toastmasterId});
  final bool isAGuest;
  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<EvaluationNotesObservationsTabView> createState() =>
      _EvaluationNotesObservationsTabViewState();
}

class _EvaluationNotesObservationsTabViewState
    extends State<EvaluationNotesObservationsTabView> {
  SpeechObservationsViewModel? _speechObservationsViewModel;

  @override
  void initState() {
    super.initState();
    _speechObservationsViewModel =
        Provider.of<SpeechObservationsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Expanded(
        child: StreamBuilder<List<SpeechEvaluationNote>>(
          stream: _speechObservationsViewModel!.getAllEvaluationNotes(
            currentSpeakerisAppGuest: widget.isAGuest,
            chapterMeetingId: widget.chapterMeetingId,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            currentSpeakerGuestInvitationCode: widget.guestInvitationCode,
            currentSpeakerToastmasterId: widget.toastmasterId,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(AppMainColors.p40),
                ),
              );
            } else {
              final List<SpeechEvaluationNote> notes = snapshot.data!;
              notes
                  .sort((a, b) => b.noteTakenTime!.compareTo(a.noteTakenTime!));

              if (notes.isEmpty) {
                return const Center(
                  child: Text(
                    "You Do Not Have Any Evaluation Notes Yet.",
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p50),
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: notes.length,
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return evaluationNoteCard(
                        iconButtonAction: () async {
                          showMaterialModalBottomSheet(
                            enableDrag: false,
                            backgroundColor:
                                const Color(AppMainColors.backgroundAndContent),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    CommonUIProperties.modalBottomSheetsEdges),
                                topRight: Radius.circular(
                                    CommonUIProperties.modalBottomSheetsEdges),
                              ),
                            ),
                            context: context,
                            builder: (context) => ViewNoteDetailsBottomSheet(
                              noteContent: notes[index].noteContent!,
                              noteTitle: notes[index].noteTitle!,
                            ),
                          );
                        },
                        noteContent: notes[index].noteContent!,
                        noteTitle: notes[index].noteTitle);
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
