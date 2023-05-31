import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/speaker_observed_data/speaker_observed_data_view.dart';

class ManageSpeechEvaluationView extends StatefulWidget {
  const ManageSpeechEvaluationView({
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
  State<ManageSpeechEvaluationView> createState() =>
      _ManageSpeechEvaluationViewState();
}

class _ManageSpeechEvaluationViewState extends State<ManageSpeechEvaluationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            height: 50,
            decoration: BoxDecoration(
              color: const Color(AppMainColors.p100),
              borderRadius:
                  BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
            ),
            child: TabBar(
              controller: _tabController,
              // padding:
              //     const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5,
                ),
                border: Border.all(color: Color(AppMainColors.p5), width: 1.3),
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
                      "Speech Evaluation",
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
                      "Speech Observations",
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
                const Center(child: Text("Speech Evaluator tools")),
                SpeakerObservedDataViwe(
                  isAGuest: widget.isAGuest,
                  chapterMeetingId: widget.chapterMeetingId,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                  guestInvitationCode: widget.guestInvitationCode,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
