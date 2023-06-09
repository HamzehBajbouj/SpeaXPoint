import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/speaker_observed_data/tab_views/evaluations_notes_observations_tab_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/speaker_observed_data/tab_views/grammatical_notes_observations_tab_view.dart';

class SpeechObservationsTabViewBar extends StatefulWidget {
  const SpeechObservationsTabViewBar(
      {super.key,
      required this.isAGuest,
      this.chapterMeetingId,
      this.chapterMeetingInvitationCode,
      this.guestInvitationCode,
      this.toastmasterId});
  final bool isAGuest;
  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<SpeechObservationsTabViewBar> createState() =>
      _SpeechObservationsTabViewBarState();
}

class _SpeechObservationsTabViewBarState
    extends State<SpeechObservationsTabViewBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              border:
                  Border.all(color: const Color(AppMainColors.p5), width: 1.3),
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
                    "Evaluation Notes",
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
                    "Grammatical Notes",
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
              EvaluationNotesObservationsTabView(
                isAGuest: widget.isAGuest,
                chapterMeetingId: widget.chapterMeetingId,
                chapterMeetingInvitationCode:
                    widget.chapterMeetingInvitationCode,
                guestInvitationCode: widget.guestInvitationCode,
                toastmasterId: widget.toastmasterId,
              ),
              GrammmaticalNotesObservationsTabView(
                isAGuest: widget.isAGuest,
                chapterMeetingId: widget.chapterMeetingId,
                chapterMeetingInvitationCode:
                    widget.chapterMeetingInvitationCode,
                guestInvitationCode: widget.guestInvitationCode,
                toastmasterId: widget.toastmasterId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
