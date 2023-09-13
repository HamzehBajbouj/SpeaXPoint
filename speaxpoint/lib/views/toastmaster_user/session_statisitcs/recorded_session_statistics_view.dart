import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/views/toastmaster_user/session_statisitcs/statistics_tab_views/evaluation_statistics_view_tab.dart';
import 'package:speaxpoint/views/toastmaster_user/session_statisitcs/statistics_tab_views/grammatical_statistics_tab_view.dart';
import 'package:speaxpoint/views/toastmaster_user/session_statisitcs/statistics_tab_views/time_filler_statistics_tab_view.dart';
import 'package:speaxpoint/views/toastmaster_user/session_statisitcs/statistics_tab_views/timing_statistics_tab_view.dart';

class RecordedSessionStatisticsView extends StatefulWidget {
  const RecordedSessionStatisticsView({
    super.key,
    required this.chapterMeetingId,
    required this.toastmasterId,
  });
  final String chapterMeetingId;
  final String toastmasterId;

  @override
  State<RecordedSessionStatisticsView> createState() =>
      _RecordedSessionStatisticsViewState();
}

class _RecordedSessionStatisticsViewState
    extends State<RecordedSessionStatisticsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(AppMainColors.p70),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Session Statistics",
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p70),
          ),
        ),
      ),
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(AppMainColors.p100),
                  borderRadius: BorderRadius.circular(
                      CommonUIProperties.cardRoundedEdges),
                ),
                child: TabBar(
                  controller: _tabController,
                  // padding:
                  //     const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    border: Border.all(
                        color: const Color(AppMainColors.p5), width: 1.3),
                  ),
                  // indicatorSize: TabBarIndicatorSize.label,
                  labelColor: const Color(AppMainColors.p5),
                  indicatorColor: Colors.white,
                  unselectedLabelColor: const Color(AppMainColors.p80),
                  tabs: const [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Tab(
                        child: Text(
                          "Fillers",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Tab(
                        child: Text(
                          "Timing",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Tab(
                        child: Text(
                          "Evaluation",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Tab(
                        child: Text(
                          "Grammar",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TimeFillerStatisticsTabView(
                      chapterMeetingId: widget.chapterMeetingId,
                      toastmasterId: widget.toastmasterId,
                    ),
                    TimingStatisticsTabView(
                      chapterMeetingId: widget.chapterMeetingId,
                      toastmasterId: widget.toastmasterId,
                    ),
                    EvaluationStatisticsTabView(
                      chapterMeetingId: widget.chapterMeetingId,
                      toastmasterId: widget.toastmasterId,
                    ),
                    GrammaticalStatisticsTabView(
                      chapterMeetingId: widget.chapterMeetingId,
                      toastmasterId: widget.toastmasterId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
