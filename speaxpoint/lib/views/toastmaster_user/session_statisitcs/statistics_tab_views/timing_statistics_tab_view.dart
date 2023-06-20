import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/speech_timing.dart';
import 'package:speaxpoint/util/common_methods.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/statisitcs/session_statistics_view_model.dart';

class TimingStatisticsTabView extends StatefulWidget {
  const TimingStatisticsTabView({
    super.key,
    required this.chapterMeetingId,
    required this.toastmasterId,
  });
  final String chapterMeetingId;
  final String toastmasterId;
  @override
  State<TimingStatisticsTabView> createState() =>
      _TimingStatisticsTabViewState();
}

class _TimingStatisticsTabViewState extends State<TimingStatisticsTabView> {
  late SessionStatisticsViewModel _sessionStatisticsViewModel;
  @override
  void initState() {
    super.initState();
    _sessionStatisticsViewModel =
        Provider.of<SessionStatisticsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _sessionStatisticsViewModel.getSpeechTimingData(
          chapterMeetingId: widget.chapterMeetingId,
          toastmasterId: widget.toastmasterId),
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
            SpeechTiming speechTiming = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(AppMainColors.p100),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Starting Time",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                            Text(
                              speechTiming.timeCounterStartingTime == null
                                  ? "No Timing Data"
                                  : DateFormat.jms(
                                      findTimeDifferenceLocalNowAndReceivedUTC(
                                      receivedUTCTime:
                                          speechTiming.timeCounterStartingTime!,
                                    )).toString(),
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
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
                              "Ending Time",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                            Text(
                              speechTiming.timeCounterEndingTime == null
                                  ? "No Timing Data"
                                  : DateFormat.jms(
                                      findTimeDifferenceLocalNowAndReceivedUTC(
                                        receivedUTCTime:
                                            speechTiming.timeCounterEndingTime!,
                                      ),
                                    ).toString(),
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
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
                              "Speech Time",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                            Text(
                              speechTiming.timeCounterEndingTime == null ||
                                      speechTiming.timeCounterStartingTime ==
                                          null
                                  ? "No Timing Data"
                                  : _getSpeechTime(
                                      startingDate:
                                          speechTiming.timeCounterStartingTime!,
                                      endingDate:
                                          speechTiming.timeCounterEndingTime!,
                                    ),
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(AppMainColors.backgroundAndContent),
                          thickness: 0.8,
                          height: 20,
                        ),
                        const Text(
                          "Timing Sequence",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.backgroundAndContent),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Grean Light",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(
                                    AppMainColors.completedSessionCardIcon),
                              ),
                            ),
                            Text(
                              speechTiming.greenLightLimit == null
                                  ? "No Timing Data"
                                  : "${getOrdinal(speechTiming.greenLightLimit!)} minute",
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Yellow Light",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color:
                                    Color(AppMainColors.ongoingSessionCardIcon),
                              ),
                            ),
                            Text(
                              speechTiming.yellowLightLimit == null
                                  ? "No Timing Data"
                                  : "${getOrdinal(speechTiming.yellowLightLimit!)} minute",
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Red Light",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color:
                                    Color(AppMainColors.pendingSessionCardIcon),
                              ),
                            ),
                            Text(
                              speechTiming.redLightLimit == null
                                  ? "No Timing Data"
                                  : "${getOrdinal(speechTiming.redLightLimit!)} minute",
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(AppMainColors.backgroundAndContent),
                          thickness: 0.8,
                          height: 20,
                        ),
                        const Text(
                          "Timing Summary",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.backgroundAndContent),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              _checkIfAllDataExist(speechTiming)
                                  ? getSpeakerTimingSummary(
                                      endingTime:
                                          speechTiming.timeCounterEndingTime!,
                                      startingTime:
                                          speechTiming.timeCounterStartingTime!,
                                      greenTime: speechTiming.greenLightLimit!,
                                      yellow: speechTiming.yellowLightLimit!,
                                      red: speechTiming.redLightLimit!,
                                      speakerName: null,
                                    )
                                  : "Not Timing Summary Is Available",
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color:
                                    Color(AppMainColors.backgroundAndContent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
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
    );
  }


  String _getSpeechTime(
      {required String startingDate, required String endingDate}) {
    DateTime date1 = DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(startingDate);
    DateTime date2 = DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(endingDate);
    Duration difference = date2.difference(date1);

    String formattedDifference = _formatDuration(difference);

    return formattedDifference;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  //false if not exist , true if exist
  bool _checkIfAllDataExist(SpeechTiming speechTiming) {
    return speechTiming.greenLightLimit != null ||
        speechTiming.yellowLightLimit != null ||
        speechTiming.redLightLimit != null ||
        speechTiming.timeCounterStartingTime != null ||
        speechTiming.timeCounterEndingTime != null;
  }
}
