import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/time_filler_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/count_time_fillers/time_filler_counter_.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/count_time_fillers/time_filler_notes.dart';

class CountTimeFillersView extends StatefulWidget {
  const CountTimeFillersView({
    super.key,
    this.chapterMeetingId,
    required this.isAGuest,
    this.chapterMeetingInvitationCode,
    this.guestHasRole,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final bool? guestHasRole;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<CountTimeFillersView> createState() => _CountTimeFillersViewState();
}

class _CountTimeFillersViewState extends State<CountTimeFillersView> {
  TimeFillerViewModel? _timeFillerViewModel;
  OnlineSession _onlineSessionDetails = OnlineSession();
  bool _isLoadingRequest1 = true;

  @override
  void initState() {
    super.initState();
    _timeFillerViewModel =
        Provider.of<TimeFillerViewModel>(context, listen: false);
    _timeFillerViewModel!
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
        : Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: Column(
              children: [
                generalMeetingGeneralInfoCard(
                    title: "Current Speaker",
                    content: _onlineSessionDetails.thereIsSelectedSpeaker! &&
                            _onlineSessionDetails.currentSpeakerName != null
                        ? _onlineSessionDetails.currentSpeakerName!
                        : "No Speaker Yet!"),
                const SizedBox(
                  height: 15,
                ),
                _onlineSessionDetails.thereIsSelectedSpeaker! &&
                        _onlineSessionDetails.currentSpeakerName != null
                    ? StreamBuilder<Map<String, int>>(
                        stream: _timeFillerViewModel!.getTimeFillerLiveData(
                            chapterMeetingId: widget.chapterMeetingId,
                            chapterMeetingInvitationCode:
                                widget.chapterMeetingInvitationCode,
                            currentSpeakerisAppGuest:
                                _onlineSessionDetails.isGuest!,
                            currentSpeakerGuestInvitationCode:
                                _onlineSessionDetails
                                    .currentGuestSpeakerInvitationCode,
                            currentSpeakerToastmasterId: _onlineSessionDetails
                                .currentSpeakerToastmasterId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(AppMainColors.p40),
                              ),
                            );
                          } else {
                            final Map<String, int> counterData = snapshot.data!;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TimeFillerCounter(
                                      counterTitle: "Long Pauses",
                                      counterNumber: counterData.containsKey(
                                              TypesOfTimeFillers
                                                  .LongPauses.name)
                                          ? counterData["LongPauses"].toString()
                                          : "0",
                                      decrementcallBack: () async {
                                        if (counterData.containsKey(
                                                TypesOfTimeFillers
                                                    .LongPauses.name) &&
                                            counterData["LongPauses"]
                                                    .toString() !=
                                                "0") {
                                          decreaseCounterCallBack(
                                              typeOfTimeFiller:
                                                  TypesOfTimeFillers
                                                      .LongPauses.name);
                                        }
                                      },
                                      incrementcallBack: () async {
                                        await increaseCounterCallBack(
                                            typeOfTimeFiller: TypesOfTimeFillers
                                                .LongPauses.name);
                                      },
                                    ),
                                    TimeFillerCounter(
                                      counterTitle: "Repeated Words",
                                      counterNumber: counterData.containsKey(
                                              TypesOfTimeFillers
                                                  .RepeatedWords.name)
                                          ? counterData[TypesOfTimeFillers
                                                  .RepeatedWords.name]
                                              .toString()
                                          : "0",
                                      decrementcallBack: () async {
                                        if (counterData.containsKey(
                                                TypesOfTimeFillers
                                                    .RepeatedWords.name) &&
                                            counterData["RepeatedWords"]
                                                    .toString() !=
                                                "0") {
                                          await decreaseCounterCallBack(
                                              typeOfTimeFiller:
                                                  TypesOfTimeFillers
                                                      .RepeatedWords.name);
                                        }
                                      },
                                      incrementcallBack: () async {
                                        await increaseCounterCallBack(
                                            typeOfTimeFiller: TypesOfTimeFillers
                                                .RepeatedWords.name);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TimeFillerCounter(
                                      counterTitle: "Out Of Context",
                                      counterNumber: counterData.containsKey(
                                              TypesOfTimeFillers
                                                  .OutOfContext.name)
                                          ? counterData[TypesOfTimeFillers
                                                  .OutOfContext.name]
                                              .toString()
                                          : "0",
                                      decrementcallBack: () async {
                                        if (counterData.containsKey(
                                                TypesOfTimeFillers
                                                    .OutOfContext.name) &&
                                            counterData["OutOfContext"]
                                                    .toString() !=
                                                "0") {
                                          await decreaseCounterCallBack(
                                              typeOfTimeFiller:
                                                  TypesOfTimeFillers
                                                      .OutOfContext.name);
                                        }
                                      },
                                      incrementcallBack: () async {
                                        await increaseCounterCallBack(
                                            typeOfTimeFiller: TypesOfTimeFillers
                                                .OutOfContext.name);
                                      },
                                    ),
                                    TimeFillerCounter(
                                      counterTitle: "Filled Pauses",
                                      counterNumber: counterData.containsKey(
                                              TypesOfTimeFillers
                                                  .FilledPauses.name)
                                          ? counterData[TypesOfTimeFillers
                                                  .FilledPauses.name]
                                              .toString()
                                          : "0",
                                      decrementcallBack: () async {
                                        if (counterData.containsKey(
                                                TypesOfTimeFillers
                                                    .FilledPauses.name) &&
                                            counterData["FilledPauses"]
                                                    .toString() !=
                                                "0") {
                                          await decreaseCounterCallBack(
                                              typeOfTimeFiller:
                                                  TypesOfTimeFillers
                                                      .FilledPauses.name);
                                        }
                                      },
                                      incrementcallBack: () async {
                                        await increaseCounterCallBack(
                                            typeOfTimeFiller: TypesOfTimeFillers
                                                .FilledPauses.name);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
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
                TimeFillerNotes(
                  isAGuest: widget.isAGuest,
                  guestInvitationCode: widget.guestInvitationCode,
                  chapterMeetingId: widget.chapterMeetingId,
                  toastmasterId: widget.toastmasterId,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                ),
              ],
            ),
          );
  }

  Future<void> increaseCounterCallBack(
      {required String typeOfTimeFiller}) async {
    await _timeFillerViewModel!.incrementTimeFiller(
      chapterMeetingId: widget.chapterMeetingId,
      chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
      typeOfTimeFiller: typeOfTimeFiller,
      currentSpeakerisAppGuest: _onlineSessionDetails.isGuest!,
      currentSpeakerGuestInvitationCode:
          _onlineSessionDetails.currentGuestSpeakerInvitationCode,
      currentSpeakerToastmasterId:
          _onlineSessionDetails.currentSpeakerToastmasterId,
    );
  }

  Future<void> decreaseCounterCallBack(
      {required String typeOfTimeFiller}) async {
    await _timeFillerViewModel!.decrementTimeFiller(
      chapterMeetingId: widget.chapterMeetingId,
      chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
      typeOfTimeFiller: typeOfTimeFiller,
      currentSpeakerisAppGuest: _onlineSessionDetails.isGuest!,
      currentSpeakerGuestInvitationCode:
          _onlineSessionDetails.currentGuestSpeakerInvitationCode,
      currentSpeakerToastmasterId:
          _onlineSessionDetails.currentSpeakerToastmasterId,
    );
  }
}
