import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/manage_role_players/manage_roles_players_view.dart';

class VPEManageRolePlayersScreen extends StatefulWidget {
  final String chapterMeetingId;
  final String roleName;
  final Widget roleView;
  const VPEManageRolePlayersScreen({
    super.key,
    required this.chapterMeetingId,
    required this.roleName,
    required this.roleView,
  });

  @override
  State<VPEManageRolePlayersScreen> createState() =>
      _VPEManageRolePlayersScreenState();
}

class _VPEManageRolePlayersScreenState extends State<VPEManageRolePlayersScreen>
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
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5,
              ),
              border: Border.all(color: Color(AppMainColors.p5), width: 1.3),
            ),
            labelColor: const Color(AppMainColors.p5),
            indicatorColor: Colors.white,
            unselectedLabelColor: const Color(AppMainColors.p80),
            tabs: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Tab(
                  child: Text(
                    "Manage Role Players",
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
                    "${widget.roleName} View",
                    style: const TextStyle(
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
              ManageRolesPlayersView(
                chapterMeetingId: widget.chapterMeetingId,
              ),
              widget.roleView,
            ],
          ),
        ),
      ],
    );
  }
}
