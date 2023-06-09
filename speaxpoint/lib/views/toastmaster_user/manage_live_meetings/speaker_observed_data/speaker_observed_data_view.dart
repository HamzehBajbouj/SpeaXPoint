import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/speech_observations_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/speaker_observed_data/speech_observations_tab_view_bar.dart';

class SpeakerObservedDataViwe extends StatefulWidget {
  const SpeakerObservedDataViwe({
    super.key,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.toastmasterId,
    this.chapterMeetingId,
  });
  /*
    since the ObservedData screen will show all the collected Data for the current user,
    not for any other users, so these parameters that are passed from the constructor are
    refering to the current user.
    once the selected speech/speaker by the VPE changes and when it matches these parameters
    then we will show the data of the current logged user.
  */
  final bool isAGuest;
  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<SpeakerObservedDataViwe> createState() =>
      _SpeakerObservedDataScreenState();
}

class _SpeakerObservedDataScreenState extends State<SpeakerObservedDataViwe> {
  SpeechObservationsViewModel? _speechObservationsViewModel;
  OnlineSession _onlineSessionDetails = OnlineSession();
  bool _isLoadingRequest1 = true;
  bool showSpeechObservations = false;
  String _formattedTime = "00:00:00";
  String lastStoredSpeechTime = "00:00:00";
  @override
  void initState() {
    super.initState();
    _speechObservationsViewModel =
        Provider.of<SpeechObservationsViewModel>(context, listen: false);
    _speechObservationsViewModel!
        .getOnlineSessionDetails(
            isAnAppGuest: widget.isAGuest,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            chapterMeetingId: widget.chapterMeetingId)
        .listen(
      (data) {
        setState(
          () {
            _onlineSessionDetails = data;
            _isLoadingRequest1 = false;
            showSpeechObservations =
                _onlineSessionDetails.thereIsSelectedSpeaker != null &&
                    _onlineSessionDetails.thereIsSelectedSpeaker! &&
                    (_onlineSessionDetails.isGuest!
                        ? (_onlineSessionDetails
                                .currentGuestSpeakerInvitationCode ==
                            widget.guestInvitationCode)
                        : (_onlineSessionDetails.currentSpeakerToastmasterId ==
                            widget.toastmasterId));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return
    if (_isLoadingRequest1) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(AppMainColors.p40),
        ),
      );
    } else {
      if (showSpeechObservations) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  fit: BoxFit.fill,
                  "assets/images/memory_storage.svg",
                  allowDrawingOutsideViewBox: false,
                  width: 150,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<SpeechTiming>(
                stream: _speechObservationsViewModel!.getSpeechTimingDetails(
                  currentSpeakerisAppGuest: widget.isAGuest,
                  chapterMeetingId: widget.chapterMeetingId,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                  currentSpeakerGuestInvitationCode: widget.guestInvitationCode,
                  currentSpeakerToastmasterId: widget.toastmasterId,
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return getSpeechTimer(
                        title: "Speech Timer -Has Not Started Yet-");
                  } else {
                    final SpeechTiming speechTiming = snapshot.data!;

                    /*
                    check if the time is going, if so , display it here ,
                    else if it's stopped, display the moment when it was stopped,
                    displaying the moment when it was stopped has two cases
                    when we refresh the screen or we open the screen for the first time 
                    then we get it from the database

                    the other case , when we are in the screen and didn't exit it
                    we want to get the latest stored internally without the need 
                    to connect to the database
                    */
                    if (speechTiming.timeCounterStartingTime != null &&
                        speechTiming.timeCounterStarted != null &&
                        speechTiming.timeCounterStarted!) {
                      return StreamBuilder<int>(
                        stream: Stream.periodic(
                            const Duration(seconds: 1), (count) => count),
                        builder: (context, snapshot) {
                          // Calculate the updated _formattedTime every 1 second
                          _formattedTime = formatTime(
                            DateTime.now().difference(
                              findTimeDifferenceLocalNowAndReceivedUTC(
                                receivedUTCTime:
                                    speechTiming.timeCounterStartingTime!,
                              ),
                            ),
                          );
                          lastStoredSpeechTime = _formattedTime;
                          return getSpeechTimer(title: "Speech Timer");
                        },
                      );
                    } else if (speechTiming.timeCounterStarted != null &&
                        speechTiming.timeCounterStarted! == false) {
                      _formattedTime = lastStoredSpeechTime;
                      if (speechTiming.timeCounterStartingTime != null &&
                          speechTiming.timeCounterEndingTime != null) {
                        //if the screen was loaded get the previous data from the database
                        double timeDifferecne = getDateTimeDifferenceInMinutes(
                            startingDateTime:
                                speechTiming.timeCounterStartingTime!,
                            endDateTime: speechTiming.timeCounterEndingTime!);
                        int speechMinutes = timeDifferecne.toInt();
                        double speechSecondDouble =
                            ((timeDifferecne - timeDifferecne.toInt()) * 60);
                        int speechSeconds = speechSecondDouble.toInt();

                        _formattedTime = formatTime(
                          Duration(
                              minutes: speechMinutes, seconds: speechSeconds),
                        );
                        return getSpeechTimer(title: "Speech Timer");
                      } else {
                        //if the timer is stopped just get the latest stored state about the timer
                        _formattedTime = lastStoredSpeechTime;
                        return getSpeechTimer(title: "Speech Timer");
                      }
                    } else {
                      return getSpeechTimer(title: "Speech Timer");
                    }
                  }
                },
              ),
              const Divider(
                thickness: 0.8,
                color: Color(AppMainColors.p20),
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<int>(
                    stream: _speechObservationsViewModel!.getWOTDCounter(
                      currentSpeakerisAppGuest: widget.isAGuest,
                      chapterMeetingId: widget.chapterMeetingId,
                      chapterMeetingInvitationCode:
                          widget.chapterMeetingInvitationCode,
                      currentSpeakerGuestInvitationCode:
                          widget.guestInvitationCode,
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
                        final int counterData = snapshot.data!;
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "$counterData",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p60),
                                  ),
                                ),
                              ),
                              const Text(
                                "WOTD",
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p30),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  StreamBuilder<int>(
                    stream: _speechObservationsViewModel!.getTimeFillersCounter(
                      currentSpeakerisAppGuest: widget.isAGuest,
                      chapterMeetingId: widget.chapterMeetingId,
                      chapterMeetingInvitationCode:
                          widget.chapterMeetingInvitationCode,
                      currentSpeakerGuestInvitationCode:
                          widget.guestInvitationCode,
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
                        final int counterData = snapshot.data!;
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "$counterData",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p60),
                                  ),
                                ),
                              ),
                              const Text(
                                "Time Fillers",
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p30),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<int>(
                    stream: _speechObservationsViewModel!
                        .getGrammaticalNotesCounter(
                      currentSpeakerisAppGuest: widget.isAGuest,
                      chapterMeetingId: widget.chapterMeetingId,
                      chapterMeetingInvitationCode:
                          widget.chapterMeetingInvitationCode,
                      currentSpeakerGuestInvitationCode:
                          widget.guestInvitationCode,
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
                        final int counterData = snapshot.data!;
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "$counterData",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p60),
                                  ),
                                ),
                              ),
                              const Text(
                                "Grammatical Notes",
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p30),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  StreamBuilder<int>(
                    stream:
                        _speechObservationsViewModel!.getEvaluationNotesCounter(
                      currentSpeakerisAppGuest: widget.isAGuest,
                      chapterMeetingId: widget.chapterMeetingId,
                      chapterMeetingInvitationCode:
                          widget.chapterMeetingInvitationCode,
                      currentSpeakerGuestInvitationCode:
                          widget.guestInvitationCode,
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
                        final int counterData = snapshot.data!;
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "$counterData",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p60),
                                  ),
                                ),
                              ),
                              const Text(
                                "Evaluation Notes",
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p30),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const Divider(
                thickness: 0.8,
                color: Color(AppMainColors.p20),
                height: 30,
              ),
              SizedBox(
                  height: 350,
                  child: SpeechObservationsTabViewBar(
                    isAGuest: widget.isAGuest,
                    chapterMeetingId: widget.chapterMeetingId,
                    chapterMeetingInvitationCode:
                        widget.chapterMeetingInvitationCode,
                    guestInvitationCode: widget.chapterMeetingId,
                    toastmasterId: widget.toastmasterId,
                  )),
            ],
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                fit: BoxFit.fill,
                "assets/images/season_change.svg",
                allowDrawingOutsideViewBox: false,
                width: 150,
                height: 200,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Your Speech Has Not Started Yet",
                style: TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(AppMainColors.p90),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                width: 320,
                child: Text(
                  "Your speech has not started yet, the moment you are selected to give your speech, the collected observations will be shown.",
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
        );
      }
    }
  }

  Widget getSpeechTimer({required String title}) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            _formattedTime,
            style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 50,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p90),
              letterSpacing: 8,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p50),
            ),
          ),
        ],
      ),
    );
  }
}
