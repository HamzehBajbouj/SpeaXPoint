import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/statistics/barchart_graph.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/statisitcs/recorded_sessions_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/statisitcs/session_statistics_view_model.dart';

class TimeFillerStatisticsTabView extends StatefulWidget {
  const TimeFillerStatisticsTabView({
    super.key,
    required this.chapterMeetingId,
    required this.toastmasterId,
  });
  final String chapterMeetingId;
  final String toastmasterId;

  @override
  State<TimeFillerStatisticsTabView> createState() =>
      _TimeFillerStatisticsTabViewState();
}

class _TimeFillerStatisticsTabViewState
    extends State<TimeFillerStatisticsTabView> {
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
      future: _sessionStatisticsViewModel.getTimeFillerDetails(
          chapterMeetingId: widget.chapterMeetingId,
          toastmasterId: widget.toastmasterId),
      builder: (
        context,
        AsyncSnapshot<Map<String, int>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(AppMainColors.p40),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, int> timeFillers = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BarChartGraph(
                    filledPasues: _getValueFromMap(
                      key: TypesOfTimeFillers.FilledPauses.name,
                      map: timeFillers,
                    ),
                    longPasues: _getValueFromMap(
                      key: TypesOfTimeFillers.LongPauses.name,
                      map: timeFillers,
                    ),
                    outOfContext: _getValueFromMap(
                      key: TypesOfTimeFillers.OutOfContext.name,
                      map: timeFillers,
                    ),
                    repeatedWords: _getValueFromMap(
                      key: TypesOfTimeFillers.RepeatedWords.name,
                      map: timeFillers,
                    ),
                    maxNumber: _getMaxValueFromMap(
                          map: timeFillers,
                        ) +
                        5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Summary",
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(AppMainColors.p90),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "In general you have total of "
                    "${timeFillers.values.reduce((value, element) => value + element)} time fillers distrubtes as shown in the barchart graph.",
                    style: const TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p70),
                    ),
                  )
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

  //this methods includes some validating about whether the key exist or not
  int _getValueFromMap({required Map<String, int> map, required String key}) {
    if (map.containsKey(key)) {
      return map[key]!;
    } else {
      return 0;
    }
  }

  int _getMaxValueFromMap({required Map<String, int> map}) {
    List<String> keys = TypesOfTimeFillers.values.map((e) => e.name).toList();

    // Set the value to 0 if the key does not exist
    keys.forEach((key) {
      map.putIfAbsent(key, () => 0);
    });
    // Get the greatest value among the keys
    int max = map.values.fold(
        0,
        (previousValue, element) =>
            element > previousValue ? element : previousValue);
    return max;
  }
}
