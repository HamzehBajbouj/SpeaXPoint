import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/grammatical_observation_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/observe_grammarian_mistakes/grammatical_notes.dart';

class ObserveGrammarianMistakesView extends StatefulWidget {
  const ObserveGrammarianMistakesView({
    super.key,
    this.chapterMeetingId,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<ObserveGrammarianMistakesView> createState() =>
      _ObserveGrammarianMistakesScreenState();
}

class _ObserveGrammarianMistakesScreenState
    extends State<ObserveGrammarianMistakesView> {
  GrammaticalObservationViewModel? _grammaticalObservationViewModel;
  OnlineSession _onlineSessionDetails = OnlineSession();
  bool _isLoadingRequest1 = true;
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _grammaticalObservationViewModel =
        Provider.of<GrammaticalObservationViewModel>(context, listen: false);
    _grammaticalObservationViewModel!
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
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingRequest1
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(AppMainColors.p40),
            ),
          )
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Column(
                  children: [
                    generalMeetingGeneralInfoCard(
                        title: "Current Speaker",
                        content: _onlineSessionDetails
                                    .thereIsSelectedSpeaker! &&
                                _onlineSessionDetails.currentSpeakerName != null
                            ? _onlineSessionDetails.currentSpeakerName!
                            : "No Speaker Yet!"),
                    const SizedBox(
                      height: 15,
                    ),
                    _onlineSessionDetails.thereIsSelectedSpeaker! &&
                            _onlineSessionDetails.currentSpeakerName != null
                        ? Column(
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  minHeight: 80,
                                  maxHeight: 90,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(AppMainColors.p60),
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      CommonUIProperties.cardRoundedEdges),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await _grammaticalObservationViewModel!
                                            .decreaseWOTDCounter(
                                          chapterMeetingId:
                                              widget.chapterMeetingId,
                                          chapterMeetingInvitationCode: widget
                                              .chapterMeetingInvitationCode,
                                          currentSpeakerisAppGuest:
                                              _onlineSessionDetails.isGuest!,
                                          currentSpeakerGuestInvitationCode:
                                              _onlineSessionDetails
                                                  .currentGuestSpeakerInvitationCode,
                                          currentSpeakerToastmasterId:
                                              _onlineSessionDetails
                                                  .currentSpeakerToastmasterId,
                                        );
                                      },
                                      child: const SizedBox(
                                        width: 100,
                                        child: Center(
                                          child: Icon(
                                            size: 35,
                                            Icons.remove,
                                            color: Color(AppMainColors.p50),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 1.3,
                                      color: Color(AppMainColors.p50),
                                      width: 0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          StreamBuilder<int>(
                                            stream: _grammaticalObservationViewModel!
                                                .getWOTDUsagesLiveDataCount(
                                                    chapterMeetingId:
                                                        widget.chapterMeetingId,
                                                    chapterMeetingInvitationCode:
                                                        widget
                                                            .chapterMeetingInvitationCode,
                                                    currentSpeakerisAppGuest:
                                                        _onlineSessionDetails
                                                            .isGuest!,
                                                    currentSpeakerGuestInvitationCode:
                                                        _onlineSessionDetails
                                                            .currentGuestSpeakerInvitationCode,
                                                    currentSpeakerToastmasterId:
                                                        _onlineSessionDetails
                                                            .currentSpeakerToastmasterId),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color(
                                                        AppMainColors.p40),
                                                  ),
                                                );
                                              } else {
                                                final int counterData =
                                                    snapshot.data!;
                                                return Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        "$counterData",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              CommonUIProperties
                                                                  .fontType,
                                                          fontSize: 70,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              AppMainColors
                                                                  .p80),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 3),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "WOTD",
                                                style: TextStyle(
                                                  fontFamily: CommonUIProperties
                                                      .fontType,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      Color(AppMainColors.p80),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      thickness: 1.3,
                                      color: Color(AppMainColors.p50),
                                      width: 0,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await _grammaticalObservationViewModel!
                                            .increaseWOTDCounter(
                                          chapterMeetingId:
                                              widget.chapterMeetingId,
                                          chapterMeetingInvitationCode: widget
                                              .chapterMeetingInvitationCode,
                                          currentSpeakerisAppGuest:
                                              _onlineSessionDetails.isGuest!,
                                          currentSpeakerGuestInvitationCode:
                                              _onlineSessionDetails
                                                  .currentGuestSpeakerInvitationCode,
                                          currentSpeakerToastmasterId:
                                              _onlineSessionDetails
                                                  .currentSpeakerToastmasterId,
                                        );
                                      },
                                      child: const SizedBox(
                                        width: 100,
                                        child: Center(
                                          child: Icon(
                                            size: 35,
                                            Icons.add,
                                            color: Color(AppMainColors.p50),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      await _grammaticalObservationViewModel!
                                          .addGrammaticalNote(
                                        noteContent:
                                            _noteContentController.text,
                                        noteTitle: _noteTitleController.text,
                                        chapterMeetingId:
                                            widget.chapterMeetingId,
                                        chapterMeetingInvitationCode:
                                            widget.chapterMeetingInvitationCode,
                                        currentSpeakerisAppGuest:
                                            _onlineSessionDetails.isGuest!,
                                        currentSpeakerGuestInvitationCode:
                                            _onlineSessionDetails
                                                .currentGuestSpeakerInvitationCode,
                                        currentSpeakerToastmasterId:
                                            _onlineSessionDetails
                                                .currentSpeakerToastmasterId,
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
                            ],
                          )
                        : SizedBox(
                            height: 370,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 80,
                                ),
                                Text(
                                  "No Current Speaker Is Selected Yet",
                                  style: TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p90),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    "There is no onging/prevoius speach yet, please wait until the VPE select the next speaker.",
                                    maxLines: 4,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    GrammaticalNotes(
                      isAGuest: widget.isAGuest,
                      guestInvitationCode: widget.guestInvitationCode,
                      chapterMeetingId: widget.chapterMeetingId,
                      toastmasterId: widget.toastmasterId,
                      chapterMeetingInvitationCode:
                          widget.chapterMeetingInvitationCode,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
