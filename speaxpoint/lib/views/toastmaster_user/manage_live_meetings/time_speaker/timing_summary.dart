import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/speech_timing_view_model.dart';

class TimingSummary extends StatefulWidget {
  const TimingSummary(
      {super.key,
      this.chapterMeetingId,
      required this.isAGuest,
      this.chapterMeetingInvitationCode,
      this.guestInvitationCode,
      this.toastmasterId,
      required this.onlineSessionDetails,
      required this.remoteSpeechTiming});
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;
  final OnlineSession onlineSessionDetails;
  final SpeechTiming remoteSpeechTiming;

  @override
  State<TimingSummary> createState() => _TimingSummaryState();
}

class _TimingSummaryState extends State<TimingSummary> {
  SpeechTimingViewModel? _speechTimingViewModel;
  bool _isLoadingRequest2 = true;
  OnlineSessionCapturedData? _selectedSpeechSpeaker;
  late List<OnlineSessionCapturedData> _speechesSpeakersList;

  @override
  void initState() {
    super.initState();
    _speechTimingViewModel =
        Provider.of<SpeechTimingViewModel>(context, listen: false);

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
              "Timing Summary",
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
            : FutureBuilder(
                future: _speechTimingViewModel!.getTimingDetails(
                  chapterMeetingId: widget.chapterMeetingId,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                  currentSpeakerisAppGuest:
                      _selectedSpeechSpeaker!.isAnAppGuest!,
                  currentSpeakerGuestInvitationCode:
                      _selectedSpeechSpeaker!.guestInvitationCode,
                  currentSpeakerToastmasterId:
                      _selectedSpeechSpeaker!.toastmasterId,
                ),
                builder: (
                  context,
                  AsyncSnapshot<SpeechTiming> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(AppMainColors.p40),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      SpeechTiming tmpSpeechTiming = snapshot.data!;
                      //two type of returned widgets
                      /*
                      first type:
                      check if the current session speech speaker
                      is the same as the one selected from the bottomsheet
                      if so check if the selectedUser has previous data
                      if no, check if it's recording and display a messages
                      if it's not recording display a different message.

                      the second type: 
                      if the user is not the current speach speaker
                      and you are trying to display the timing data of another player
                      */

                      if (widget.onlineSessionDetails.thereIsSelectedSpeaker!) {
                        bool isGuestApp = _selectedSpeechSpeaker!.isAnAppGuest!;
                        bool isGuestSession =
                            widget.onlineSessionDetails.isGuest!;
                        bool isMatchingSpeaker = (isGuestApp && isGuestSession)
                            ? _selectedSpeechSpeaker!.guestInvitationCode ==
                                widget.onlineSessionDetails
                                    .currentGuestSpeakerInvitationCode
                            : _selectedSpeechSpeaker!.toastmasterId ==
                                widget.onlineSessionDetails
                                    .currentSpeakerToastmasterId;

                        if (isMatchingSpeaker) {
                          if (tmpSpeechTiming.timeCounterEndingTime != null &&
                              tmpSpeechTiming.timeCounterStartingTime != null) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  getSpeakerTimingSummary(
                                      endingTime: tmpSpeechTiming
                                          .timeCounterEndingTime!,
                                      startingTime: tmpSpeechTiming
                                          .timeCounterStartingTime!,
                                      greenTime:
                                          tmpSpeechTiming.greenLightLimit!,
                                      yellow: tmpSpeechTiming.yellowLightLimit!,
                                      red: tmpSpeechTiming.redLightLimit!,
                                      speakerName:
                                          _selectedSpeechSpeaker!.speakerName),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Color(AppMainColors.p80),
                                      fontFamily: CommonUIProperties.fontType,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            );
                          } else if (widget
                                      .remoteSpeechTiming.timeCounterStarted !=
                                  null &&
                              widget.remoteSpeechTiming.timeCounterStarted!) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "You are currently recording \"${_selectedSpeechSpeaker!.speakerName!}\""
                                  " timing data, There is no any previous recorded timing data to display. ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Color(AppMainColors.p80),
                                      fontFamily: CommonUIProperties.fontType,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "There is no any previous recorded timing data to display for speaker \"${_selectedSpeechSpeaker!.speakerName!}\"",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Color(AppMainColors.p80),
                                      fontFamily: CommonUIProperties.fontType,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            );
                          }
                        }
                      }

                      if (tmpSpeechTiming.timeCounterEndingTime != null &&
                          tmpSpeechTiming.timeCounterStartingTime != null) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              getSpeakerTimingSummary(
                                  endingTime:
                                      tmpSpeechTiming.timeCounterEndingTime!,
                                  startingTime:
                                      tmpSpeechTiming.timeCounterStartingTime!,
                                  greenTime: tmpSpeechTiming.greenLightLimit!,
                                  yellow: tmpSpeechTiming.yellowLightLimit!,
                                  red: tmpSpeechTiming.redLightLimit!,
                                  speakerName:
                                      _selectedSpeechSpeaker!.speakerName),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color(AppMainColors.p80),
                                  fontFamily: CommonUIProperties.fontType,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              "There is no any previous recorded timing data to display for speaker \"${_selectedSpeechSpeaker!.speakerName!}\"",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color(AppMainColors.p80),
                                  fontFamily: CommonUIProperties.fontType,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Text(
                          "Error: unable to fetch applicant details");
                    }
                  } else {
                    return Text(
                      'State: ${snapshot.connectionState}',
                      style: const TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.warningError75),
                      ),
                    );
                  }
                },
              ),
      ],
    );
  }

  Future<void> getListOfSpeechesSpeakers() async {
    _speechesSpeakersList = await _speechTimingViewModel!
        .getListOfSpeechesSpeakers(
            isAGuest: widget.isAGuest,
            chapterMeetingId: widget.chapterMeetingId,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
)
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

  String getSpeakerTimingSummary(
      {required String startingTime,
      required String endingTime,
      required int greenTime,
      required int yellow,
      required int red,
      required speakerName}) {
    double timeDifferecne = getDateTimeDifferenceInMinutes(
        startingDateTime: startingTime, endDateTime: endingTime);
    int speechMinutes = timeDifferecne.toInt();
    double speechSecondDouble =
        ((timeDifferecne - timeDifferecne.toInt()) * 60);
    int speechSeconds = speechSecondDouble.toInt();
    String message = "";
    if (timeDifferecne < greenTime) {
      return message =
          "Speaker \"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is less than the minimum speech time, making \"$speakerName\" NOT eligible for voting.";
    }

    if (timeDifferecne <= yellow) {
      return message =
          "Speaker \"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is more than the minimum speech time, making \"$speakerName\" eligible for voting.";
    }
    if (timeDifferecne <= red) {
      return message =
          "Speaker \"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is less than the maximum speech time, making \"$speakerName\" eligible for voting.";
    }

    if (timeDifferecne > red) {
      return message =
          "Speaker \"$speakerName\" spent $speechMinutes minutes & $speechSeconds seconds, which is more than the maximum speech time, making \"$speakerName\" NOT eligible for voting.";
    }
    return message;
  }
}
