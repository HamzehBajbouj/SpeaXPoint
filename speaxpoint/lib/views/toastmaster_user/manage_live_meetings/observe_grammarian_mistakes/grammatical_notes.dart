import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/grammatical_observation_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/grammatical_note_bottom_sheet.dart';

class GrammaticalNotes extends StatefulWidget {
  const GrammaticalNotes({
    super.key,
    required this.isAGuest,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final bool isAGuest;
  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;
  @override
  State<GrammaticalNotes> createState() => _GrammaticalNotesState();
}

class _GrammaticalNotesState extends State<GrammaticalNotes> {
  GrammaticalObservationViewModel? _grammaticalObservationViewModel;

  bool _isLoadingRequest2 = true;
  OnlineSessionCapturedData? _selectedSpeechSpeaker;
  late List<OnlineSessionCapturedData> _speechesSpeakersList;

  @override
  void initState() {
    super.initState();
    _grammaticalObservationViewModel =
        Provider.of<GrammaticalObservationViewModel>(context, listen: false);
    getListOfSpeechesSpeakers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Time Fillers Notes",
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
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p70),
                    ),
                  )
                : textButtonWithTrailingIcon(
                    callBack: () {
                      displaySpeechesSpeakersDropMenu(
                        context: context,
                        dataList: generateSelectedListItems(
                          choices: _speechesSpeakersList
                              .map((data) => data.speakerName!)
                              .toList(),
                          indexes: List.generate(
                              _speechesSpeakersList.length, (index) => index),
                        ),
                        selectedItemsCallBack: (selectedItemsList) {
                          SelectedListItem? tempItem;
                          for (var item in selectedItemsList) {
                            if (item is SelectedListItem) {
                              tempItem = item;
                            }
                          }
                          setState(
                            () {
                              _selectedSpeechSpeaker = _speechesSpeakersList[
                                  int.parse(tempItem!.value!)];
                            },
                          );
                        },
                      );
                    },
                    content: Text(
                      _selectedSpeechSpeaker == null
                          ? "Select Speaker"
                          : _selectedSpeechSpeaker!.speakerName!,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color(AppMainColors.p80),
                          fontFamily: CommonUIProperties.fontType,
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
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<int>(
                    stream: _grammaticalObservationViewModel!
                        .getWOTDUsagesLiveDataCount(
                            chapterMeetingId: widget.chapterMeetingId,
                            chapterMeetingInvitationCode:
                                widget.chapterMeetingInvitationCode,
                            currentSpeakerisAppGuest:
                                _selectedSpeechSpeaker!.isAnAppGuest!,
                            currentSpeakerGuestInvitationCode:
                                _selectedSpeechSpeaker!.guestInvitationCode,
                            currentSpeakerToastmasterId:
                                _selectedSpeechSpeaker!.toastmasterId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(AppMainColors.p40),
                          ),
                        );
                      } else {
                        final int counterData = snapshot.data!;
                        return Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("$counterData",
                                  style: const TextStyle(
                                      fontSize: 60,
                                      color: Color(AppMainColors.p90),
                                      fontFamily: CommonUIProperties.fontType,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Expanded(
                              child: Text(
                                "Is the total number of the usages of word of the day that was captured during the session.",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(AppMainColors.p60),
                                    fontFamily: CommonUIProperties.fontType,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Grammatical Notes",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(AppMainColors.p90),
                        fontFamily: CommonUIProperties.fontType,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 200,
                    child: Expanded(
                      child: StreamBuilder<List<GrammarianNote>>(
                        stream: _grammaticalObservationViewModel!
                            .getGrammaticalNotes(
                          currentSpeakerisAppGuest:
                              _selectedSpeechSpeaker!.isAnAppGuest!,
                          currentSpeakerGuestInvitationCode:
                              _selectedSpeechSpeaker!.guestInvitationCode,
                          currentSpeakerToastmasterId:
                              _selectedSpeechSpeaker!.toastmasterId,
                          chapterMeetingId: widget.chapterMeetingId,
                          chapterMeetingInvitationCode:
                              widget.chapterMeetingInvitationCode,
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(AppMainColors.p40),
                              ),
                            );
                          } else {
                            final List<GrammarianNote> notes = snapshot.data!;
                            notes.sort((a, b) => b.noteCapturedTime!
                                .compareTo(a.noteCapturedTime!));

                            if (notes.isEmpty) {
                              return const Center(
                                child: Text(
                                  "You Have Not Taken Any Grammatical Notes Yet.",
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
                                              AppMainColors
                                                  .backgroundAndContent),
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
                                              GrammaticalNoteBottomSheet(
                                            deleteNoteAction:
                                                _grammaticalObservationViewModel!
                                                    .deleteGrammaticalNote,
                                            chapterMeetingId:
                                                widget.chapterMeetingId,
                                            isAGuest: widget.isAGuest,
                                            grammaticalNote: notes[index],
                                            chapterMeetingInvitationCode: widget
                                                .chapterMeetingInvitationCode,
                                            guestInvitationCode:
                                                _selectedSpeechSpeaker!
                                                    .guestInvitationCode,
                                            toastmasterId:
                                                _selectedSpeechSpeaker!
                                                    .toastmasterId,
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
                  )
                ],
              ),
      ],
    );
  }

  Future<void> getListOfSpeechesSpeakers() async {
    _speechesSpeakersList = await _grammaticalObservationViewModel!
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
}
