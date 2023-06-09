import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/speech_timing_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/time_speaker/time_counter_bar.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/time_speaker/timing_summary.dart';

class TimeSpeakerView extends StatefulWidget {
  const TimeSpeakerView({
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
  State<TimeSpeakerView> createState() => _TimeSpeakerScreenState();
}

class _TimeSpeakerScreenState extends State<TimeSpeakerView> {
  final TextEditingController _greenLightTimeController =
      TextEditingController();
  final TextEditingController _yellowLightTimeController =
      TextEditingController();
  final TextEditingController _redLightTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoadingRequest1 = true;
  bool _enableButtonAction = true;
  bool _hideWarningMessage = false;

  SpeechTimingViewModel? _speechTimingViewModel;
  OnlineSession _onlineSessionDetails = OnlineSession();

  SpeechTiming speechTiming = SpeechTiming(
    timeCounterStarted: false,
  );

  @override
  void initState() {
    super.initState();

    _speechTimingViewModel =
        Provider.of<SpeechTimingViewModel>(context, listen: false);

    _speechTimingViewModel!
        .getOnlineSessionDetails(
            isAnAppGuest: widget.isAGuest,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            chapterMeetingId: widget.chapterMeetingId)
        .listen(
      (data) {
        setState(() {
          _onlineSessionDetails = data;
          _isLoadingRequest1 = false;
          _greenLightTimeController.clear();
          _yellowLightTimeController.clear();
          _redLightTimeController.clear();

          _speechTimingViewModel!
              .getTimingLiveData(
            chapterMeetingId: widget.chapterMeetingId,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            currentSpeakerisAppGuest: _onlineSessionDetails.isGuest!,
            currentSpeakerGuestInvitationCode:
                _onlineSessionDetails.currentGuestSpeakerInvitationCode,
            currentSpeakerToastmasterId:
                _onlineSessionDetails.currentSpeakerToastmasterId,
          )
              .listen(
            (data) {
              setState(
                () {
                  speechTiming = data;
                  if (speechTiming.timeCounterStarted!) {
                    _greenLightTimeController.text =
                        speechTiming.greenLightLimit.toString();
                    _yellowLightTimeController.text =
                        speechTiming.yellowLightLimit.toString();
                    _redLightTimeController.text =
                        speechTiming.redLightLimit.toString();
                  }
                },
              );
            },
          );
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _greenLightTimeController.dispose();
    _yellowLightTimeController.dispose();
    _redLightTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingRequest1
        ? _onlineSessionDetails.currentSpeakerName == null
            ? Center(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
              )
            : const Center(
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
                    generalMeetingGeneralInfoCard(
                        title: "Current Speaker",
                        content: _onlineSessionDetails.thereIsSelectedSpeaker!
                            ? _onlineSessionDetails.currentSpeakerName!
                            : "No Speaker Yet!"),
                    const SizedBox(
                      height: 15,
                    ),
                    TimeCounterBar(
                      startTime: speechTiming.timeCounterStartingTime != null
                          ? findTimeDifferenceLocalNowAndReceivedUTC(
                              receivedUTCTime:
                                  speechTiming.timeCounterStartingTime!,
                            )
                          : DateTime.now(),
                      startTimeStatus:
                          speechTiming.timeCounterStartingTime != null
                              ? speechTiming.timeCounterStarted!
                              : false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Green Light Time",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(AppMainColors.p80),
                              fontFamily: CommonUIProperties.fontType,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 60,
                          child: outlineTextField(
                            controller: _greenLightTimeController,
                            hintText: "00",
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            readOnly: speechTiming.timeCounterStarted!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Yellow Light Time",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(AppMainColors.p80),
                              fontFamily: CommonUIProperties.fontType,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 60,
                          child: outlineTextField(
                            controller: _yellowLightTimeController,
                            hintText: "00",
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            readOnly: speechTiming.timeCounterStarted!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Red Light Time",
                          style: TextStyle(
                              fontSize: 17,
                              color: Color(AppMainColors.p80),
                              fontFamily: CommonUIProperties.fontType,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 60,
                          child: outlineTextField(
                            controller: _redLightTimeController,
                            hintText: "00",
                            isRequired: true,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            readOnly: speechTiming.timeCounterStarted!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    outlinedButton(
                      enableButtonAction: _enableButtonAction,
                      callBack: () async {
                        if (!_onlineSessionDetails.thereIsSelectedSpeaker!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar(
                              text: const Text(
                                "You Can't Add Note While No Speaker There Yet!",
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppMainColors.p5),
                                ),
                              ),
                              color: const Color(AppMainColors.warningError75),
                            ),
                          );
                        } else {
                          if (_formKey.currentState!.validate() &&
                              _checkOrder(
                                green:
                                    int.parse(_greenLightTimeController.text),
                                yellow:
                                    int.parse(_yellowLightTimeController.text),
                                red: int.parse(_redLightTimeController.text),
                              )) {
                            setState(() {
                              _enableButtonAction = false;
                            });
                            if (speechTiming.timeCounterStarted!) {
                              await _speechTimingViewModel!
                                  .stopTimeCounter(
                                currentSpeakerisAppGuest:
                                    _onlineSessionDetails.isGuest!,
                                currentSpeakerGuestInvitationCode:
                                    _onlineSessionDetails
                                        .currentGuestSpeakerInvitationCode,
                                currentSpeakerToastmasterId:
                                    _onlineSessionDetails
                                        .currentSpeakerToastmasterId,
                                chapterMeetingId: widget.chapterMeetingId,
                                chapterMeetingInvitationCode:
                                    widget.chapterMeetingInvitationCode,
                              )
                                  .whenComplete(() {
                                setState(() {
                                  _enableButtonAction = true;
                                });
                              });
                            } else {
                              await _speechTimingViewModel!
                                  .startTimeCounter(
                                currentSpeakerisAppGuest:
                                    _onlineSessionDetails.isGuest!,
                                currentSpeakerGuestInvitationCode:
                                    _onlineSessionDetails
                                        .currentGuestSpeakerInvitationCode,
                                currentSpeakerToastmasterId:
                                    _onlineSessionDetails
                                        .currentSpeakerToastmasterId,
                                chapterMeetingId: widget.chapterMeetingId,
                                chapterMeetingInvitationCode:
                                    widget.chapterMeetingInvitationCode,
                                greenLightLimit: _greenLightTimeController.text,
                                yellowLightLimit:
                                    _yellowLightTimeController.text,
                                redLightLimit: _redLightTimeController.text,
                              )
                                  .whenComplete(() {
                                setState(() {
                                  _enableButtonAction = true;
                                });
                              });
                            }
                          }
                        }
                      },
                      content: speechTiming.timeCounterStarted!
                          ? "Stop Timer"
                          : "Start Timer",
                      buttonColor: speechTiming.timeCounterStarted!
                          ? const Color(AppMainColors.warningError75)
                          : const Color(AppMainColors.p80),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: _hideWarningMessage,
                      child: RichText(
                        text: const TextSpan(
                          text: 'Warning : ',
                          style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 15,
                              color: Color(AppMainColors.warningError75),
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "make sure that the order is from the lights timing order is from smallest to largest.",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TimingSummary(
                      isAGuest: widget.isAGuest,
                      guestInvitationCode: widget.guestInvitationCode,
                      chapterMeetingId: widget.chapterMeetingId,
                      toastmasterId: widget.toastmasterId,
                      chapterMeetingInvitationCode:
                          widget.chapterMeetingInvitationCode,
                      onlineSessionDetails: _onlineSessionDetails,
                      remoteSpeechTiming: speechTiming,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  bool _checkOrder(
      {required int green, required int yellow, required int red}) {
    if (green < yellow && yellow < red) {
      setState(() {
        _hideWarningMessage = false;
      });
      return true;
    } else {
      setState(() {
        _hideWarningMessage = true;
      });
      return false;
    }
  }
}
