import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/manage_evaluation_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/evaluation_note_bottom_sheet.dart';

class GeneralEvaluationTabView extends StatefulWidget {
  const GeneralEvaluationTabView(
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
  State<GeneralEvaluationTabView> createState() =>
      _GeneralEvaluationTabViewState();
}

class _GeneralEvaluationTabViewState extends State<GeneralEvaluationTabView> {
  ManageEvaluationViewModel? _manageEvaluationViewModel;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteContent = TextEditingController();
  final TextEditingController _noteTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    _manageEvaluationViewModel =
        Provider.of<ManageEvaluationViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            outlineTextField(
              keyboardType: TextInputType.text,
              controller: _noteTitle,
              hintText: "Enter Note Title...",
              isRequired: false,
            ),
            const SizedBox(
              height: 15,
            ),
            outlineTextField(
              keyboardType: TextInputType.text,
              controller: _noteContent,
              hintText: "Enter Note Content...",
              isRequired: true,
              maxLines: 4,
            ),
            const SizedBox(
              height: 15,
            ),
            outlinedButton(
              callBack: () async {
                if (_formKey.currentState!.validate()) {
                  await _manageEvaluationViewModel!
                      .addNewGeneralEvaluationNote(
                    isAGuest: widget.isAGuest,
                    noteContent: _noteContent.text,
                    noteTitle: _noteTitle.text.isEmpty ? null : _noteTitle.text,
                    chapterMeetingId: widget.chapterMeetingId,
                    chapterMeetingInvitationCode:
                        widget.chapterMeetingInvitationCode,
                    guestInvitationCode: widget.guestInvitationCode,
                    toastmasterId: widget.toastmasterId,
                  )
                      .then((_) {
                    _noteContent.text = "";
                    _noteTitle.text = "";
                  });
                }
              },
              content: "Add Note",
              buttonColor: const Color(AppMainColors.p80),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Evaluation Notes",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p90),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<List<EvaluationNote>>(
                stream: _manageEvaluationViewModel!.getGeneralEvaluationNotes(
                  chapterMeetingId: widget.chapterMeetingId,
                  isAnAppGuest: widget.isAGuest,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                  guestInvitationCode: widget.guestInvitationCode,
                  toastmasterId: widget.toastmasterId,
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(AppMainColors.p40),
                      ),
                    );
                  } else {
                    final List<EvaluationNote> notes = snapshot.data!;
                    notes.sort(
                        (a, b) => b.noteTakenTime!.compareTo(a.noteTakenTime!));

                    if (notes.isEmpty) {
                      return const Center(
                        child: Text(
                          "You Don't Have any Evaluation Notes Yet.",
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
                                  backgroundColor: const Color(
                                      AppMainColors.backgroundAndContent),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          CommonUIProperties
                                              .modalBottomSheetsEdges),
                                      topRight: Radius.circular(
                                          CommonUIProperties
                                              .modalBottomSheetsEdges),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) =>
                                      EvaluationNoteBottomSheet(
                                    isGeneralEvaluation: true,
                                    chapterMeetingId: widget.chapterMeetingId,
                                    isAGuest: widget.isAGuest,
                                    evaluationNote: notes[index],
                                    chapterMeetingInvitationCode:
                                        widget.chapterMeetingInvitationCode,
                                    guestInvitationCode:
                                        widget.guestInvitationCode,
                                    toastmasterId: widget.toastmasterId,
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
          ],
        ),
      ),
    );
  }
}
