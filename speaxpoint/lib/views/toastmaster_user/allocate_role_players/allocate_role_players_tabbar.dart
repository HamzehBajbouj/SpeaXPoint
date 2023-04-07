import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/club_members_tab_view.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/visitors_tab_view.dart';

class AllocateRolePlayersTabBar extends StatefulWidget {
  final String chapterMeetingId;
  final String clubId;
  const AllocateRolePlayersTabBar({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  @override
  State<AllocateRolePlayersTabBar> createState() =>
      _AllocateRolePlayersTabBarState();
}

class _AllocateRolePlayersTabBarState extends State<AllocateRolePlayersTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
              border: Border.all(color: Color(AppMainColors.p5), width: 1.3),
            ),
            // indicatorSize: TabBarIndicatorSize.label,
            labelColor: Color(AppMainColors.p5),
            indicatorColor: Colors.white,
            unselectedLabelColor: Color(AppMainColors.p80),
            tabs: const [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Tab(
                  child: Text(
                    "Members",
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
                    "Visitors",
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
                    "Guests",
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
                    "Volunteers",
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
              ClubMembersTabView(
                chapterMeetingId: widget.chapterMeetingId,
                clubId: widget.clubId,
              ),
              const VisitorsTabView(),
              const VisitorsTabView(),
              const VisitorsTabView(),
            ],
          ),
        ),
      ],
    );
  }
}
