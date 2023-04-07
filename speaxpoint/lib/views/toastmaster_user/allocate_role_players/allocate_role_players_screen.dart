import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/allocate_role_players_tabbar.dart';

class AllocateRolePlayerScreen extends StatelessWidget {
  final String chapterMeetingId;
  final String clubId;
  const AllocateRolePlayerScreen({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

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
          "Allocate Role Players",
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p70),
          ),
        ),
      ),
      backgroundColor: Color(AppMainColors.backgroundAndContent),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Allocate Role Players",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p90),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Allocate the chapter meeting role players from your club or other clubs.",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(AppMainColors.p50),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: AllocateRolePlayersTabBar(
              chapterMeetingId: chapterMeetingId,
              clubId: clubId,
            )),
          ],
        ),
      )),
    );
  }
}
