import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/evaluation_notes/evaluation_note.dart';
import 'package:speaxpoint/models/evaluation_notes/temp_evaluation_note.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_checkers.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/options_selections.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/manage_evaluation_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/evaluation_note_bottom_sheet.dart';

class SpeechEvaluationTabView extends StatefulWidget {
  const SpeechEvaluationTabView(
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
  State<SpeechEvaluationTabView> createState() =>
      _SpeechEvaluationTabViewState();
}

class _SpeechEvaluationTabViewState extends State<SpeechEvaluationTabView> {
  ManageEvaluationViewModel? _manageEvaluationViewModel;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteTitleController = TextEditingController();

  OnlineSession _onlineSessionDetails = OnlineSession();
  bool _hideWarningMessage = true;
  bool _isLoadingRequest1 = true;
  bool _isLoadingRequest2 = true;
  OnlineSessionCapturedData? _selectedSpeechSpeaker;
  late List<OnlineSessionCapturedData> _speechesSpeakersList;

  @override
  void initState() {
    super.initState();
    _manageEvaluationViewModel =
        Provider.of<ManageEvaluationViewModel>(context, listen: false);
    _manageEvaluationViewModel!
        .getOnlineSessionDetails(
            isAnAppGuest: widget.isAGuest,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            chapterMeetingId: widget.chapterMeetingId)
        .listen((data) {
      setState(() {
        _onlineSessionDetails = data;
        _isLoadingRequest1 = false;
      });
    });
    getListOfSpeechesSpeakers();
  }

  Future<void> getListOfSpeechesSpeakers() async {
    _speechesSpeakersList = await _manageEvaluationViewModel!
        .getListOfSpeechesSpeakers(
            isAGuest: widget.isAGuest,
            chapterMeetingId: widget.chapterMeetingId,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            guestInvitationCode: widget.guestInvitationCode,
            toastmasterId: widget.toastmasterId)
        .whenComplete(
      () {
        setState(
          () {
            _isLoadingRequest2 = false;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingRequest1
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(AppMainColors.p40),
            ),
          )
        : Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    currentSpeechSpeakerCard(
                        title: "Current Speaker",
                        content: _onlineSessionDetails
                                    .thereIsSelectedSpeaker! &&
                                _onlineSessionDetails.currentSpeakerName != null
                            ? _onlineSessionDetails.currentSpeakerName!
                            : "No Speaker Yet!"),
                    checkIfCurrentSpeakerIsTheSameAsSpeechEvaluator(
                            isAnAppGuest: widget.isAGuest,
                            currentSelectSpeakerIsGuest:
                                _onlineSessionDetails.isGuest!,
                            loggedUserGuestInvitationCode:
                                widget.guestInvitationCode,
                            loggedUserToastmasterId: widget.toastmasterId,
                            selectedSpeakerGuestInvitationCode:
                                _onlineSessionDetails
                                    .currentGuestSpeakerInvitationCode,
                            selectedSpeakerToastmasterId: _onlineSessionDetails
                                .currentSpeakerToastmasterId)
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                SvgPicture.asset(
                                  fit: BoxFit.fill,
                                  "assets/images/speech_to_text.svg",
                                  allowDrawingOutsideViewBox: false,
                                  width: 150,
                                  height: 200,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  _onlineSessionDetails
                                              .thereIsSelectedSpeaker! &&
                                          _onlineSessionDetails
                                                  .currentSpeakerName !=
                                              null
                                      ? "You Can't Evaluate Yourself"
                                      : "No Current Speaker Is Selected Yet",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p90),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    _onlineSessionDetails
                                                .thereIsSelectedSpeaker! &&
                                            _onlineSessionDetails
                                                    .currentSpeakerName !=
                                                null
                                        ? "Since you are currently performing your speech, you can not evaluate yourself."
                                        : "There is no onging/prevoius speach yet, please wait until the VPE select the next speaker.",
                                    maxLines: 4,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: _hideWarningMessage,
                                child: const SizedBox(
                                  height: 10,
                                ),
                              ),
                              Visibility(
                                visible: _hideWarningMessage,
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Warning : ',
                                    style: TextStyle(
                                        fontFamily: CommonUIProperties.fontType,
                                        fontSize: 15,
                                        color:
                                            Color(AppMainColors.warningError75),
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            "only add the notes for you assigned speaker.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              outlineTextField(
                                keyboardType: TextInputType.text,
                                controller: _noteTitleController,
                                hintText: "Enter Note Title...",
                                isRequired: false,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              outlineTextField(
                                keyboardType: TextInputType.text,
                                controller: _noteContentController,
                                hintText: "Enter Note Content...",
                                isRequired: true,
                                maxLines: 4,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              outlinedButton(
                                callBack: () async {
                                  if (!_onlineSessionDetails
                                      .thereIsSelectedSpeaker!) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      getSnackBar(
                                        text: const Text(
                                          "You Can't Add Note While No Speaker There Yet!",
                                          style: TextStyle(
                                            fontFamily:
                                                CommonUIProperties.fontType,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(AppMainColors.p5),
                                          ),
                                        ),
                                        color: const Color(
                                            AppMainColors.warningError75),
                                      ),
                                    );
                                  } else {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _hideWarningMessage = false;
                                      });
                                      await _manageEvaluationViewModel!
                                          .addSpeechEvaluationNote(
                                        noteContent:
                                            _noteContentController.text,
                                        noteTitle: _noteTitleController.text,
                                        onlineSessionDetails:
                                            _onlineSessionDetails,
                                        chapterMeetingId:
                                            widget.chapterMeetingId,
                                        chapterMeetingInvitationCode:
                                            widget.chapterMeetingInvitationCode,
                                        takenByGuestInvitationCode:
                                            widget.guestInvitationCode,
                                        takenByToastmasterId:
                                            widget.toastmasterId,
                                      )
                                          .then((_) {
                                        _noteContentController.text = "";
                                        _noteTitleController.text = "";
                                      });
                                    }
                                  }
                                },
                                content: "Add Note",
                                buttonColor: const Color(AppMainColors.p80),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                    width: 3,
                                  ),
                                  _isLoadingRequest2
                                      ? const Text(
                                          "Loading...",
                                          style: TextStyle(
                                            height: 1.4,
                                            fontFamily:
                                                CommonUIProperties.fontType,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Color(AppMainColors.p70),
                                          ),
                                        )
                                      : textButtonWithTrailingIcon(
                                          callBack: () {
                                            displaySpeechesSpeakersDropMenu(
                                              context: context,
                                              dataList:
                                                  generateSelectedListItems(
                                                choices: _speechesSpeakersList
                                                    .map((data) =>
                                                        data.speakerName!)
                                                    .toList(),
                                                indexes: List.generate(
                                                    _speechesSpeakersList
                                                        .length,
                                                    (index) => index),
                                              ),
                                              selectedItemsCallBack:
                                                  (selectedItemsList) {
                                                SelectedListItem? tempItem;
                                                for (var item
                                                    in selectedItemsList) {
                                                  if (item
                                                      is SelectedListItem) {
                                                    tempItem = item;
                                                  }
                                                }
                                                setState(
                                                  () {
                                                    _selectedSpeechSpeaker =
                                                        _speechesSpeakersList[
                                                            int.parse(tempItem!
                                                                .value!)];
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          content: Text(
                                            _selectedSpeechSpeaker == null
                                                ? "Select Speaker"
                                                : _selectedSpeechSpeaker!
                                                    .speakerName!,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Color(AppMainColors.p80),
                                                fontFamily:
                                                    CommonUIProperties.fontType,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          trailingIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: Color(AppMainColors.p20),
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              _selectedSpeechSpeaker == null
                                  ? Container()
                                  : SizedBox(
                                      height: 200,
                                      child: Expanded(
                                        child: StreamBuilder<
                                            List<TempSpeechEvaluationNote>>(
                                          stream: _manageEvaluationViewModel!
                                              .getTakenNotes(
                                                  chapterMeetingId: widget
                                                      .chapterMeetingId,
                                                  isAGuest: widget.isAGuest,
                                                  chapterMeetingInvitationCode:
                                                      widget
                                                          .chapterMeetingInvitationCode,
                                                  guestInvitationCode: widget
                                                      .guestInvitationCode,
                                                  toastmasterId: widget
                                                      .toastmasterId,
                                                  evaluatedSpeakerGuestInvitationCode:
                                                      _selectedSpeechSpeaker!
                                                          .guestInvitationCode,
                                                  evaluatedSpeakerIsAppGuest:
                                                      _selectedSpeechSpeaker!
                                                          .isAnAppGuest!,
                                                  evaluatedSpeakerToastmasteId:
                                                      _selectedSpeechSpeaker!
                                                          .toastmasterId),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      Color(AppMainColors.p40),
                                                ),
                                              );
                                            } else {
                                              final List<EvaluationNote> notes =
                                                  snapshot.data!;
                                              notes.sort((a, b) => b
                                                  .noteTakenTime!
                                                  .compareTo(a.noteTakenTime!));

                                              if (notes.isEmpty) {
                                                return const Center(
                                                  child: Text(
                                                    "You Have Not Taken Any Evaluation Notes Yet.",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          CommonUIProperties
                                                              .fontType,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color(
                                                          AppMainColors.p50),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return ListView.separated(
                                                  itemCount: notes.length,
                                                  separatorBuilder:
                                                      (_, index) =>
                                                          const SizedBox(
                                                    height: 10,
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return evaluationNoteCard(
                                                        iconButtonAction:
                                                            () async {
                                                          showMaterialModalBottomSheet(
                                                            enableDrag: false,
                                                            backgroundColor:
                                                                const Color(
                                                                    AppMainColors
                                                                        .backgroundAndContent),
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        CommonUIProperties
                                                                            .modalBottomSheetsEdges),
                                                                topRight: Radius
                                                                    .circular(
                                                                        CommonUIProperties
                                                                            .modalBottomSheetsEdges),
                                                              ),
                                                            ),
                                                            context: context,
                                                            builder: (context) =>
                                                                EvaluationNoteBottomSheet(
                                                              deleteNoteAction:
                                                                  _manageEvaluationViewModel!
                                                                      .deleteSpeechEvaluationNote,
                                                              chapterMeetingId:
                                                                  widget
                                                                      .chapterMeetingId,
                                                              isAGuest: widget
                                                                  .isAGuest,
                                                              evaluationNote:
                                                                  notes[index],
                                                              chapterMeetingInvitationCode:
                                                                  widget
                                                                      .chapterMeetingInvitationCode,
                                                              guestInvitationCode:
                                                                  widget
                                                                      .guestInvitationCode,
                                                              toastmasterId: widget
                                                                  .toastmasterId,
                                                            ),
                                                          );
                                                        },
                                                        noteContent:
                                                            notes[index]
                                                                .noteContent!,
                                                        noteId: notes[index]
                                                            .noteId!,
                                                        noteTitle: notes[index]
                                                            .noteTitle);
                                                  },
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}
