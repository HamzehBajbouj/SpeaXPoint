import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';

class ManageChapterMeetingAnnouncementsScreen extends StatefulWidget {
  const ManageChapterMeetingAnnouncementsScreen(
      {super.key, required this.chapterMeetingId});

  final String chapterMeetingId;

  @override
  State<ManageChapterMeetingAnnouncementsScreen> createState() =>
      _ManageChapterMeetingAnnouncementsScreenState();
}

class _ManageChapterMeetingAnnouncementsScreenState
    extends State<ManageChapterMeetingAnnouncementsScreen> {
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
          "Announce Chapter Meeting",
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: double.infinity,
                child: SvgPicture.asset(
                  fit: BoxFit.contain,
                  "assets/images/announcement.svg",
                  allowDrawingOutsideViewBox: false,
                  width: 170,
                  height: 170,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Previous Announcements",
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(AppMainColors.p80),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  announcementCard(
                    description: "Description test",
                    onCardTap: () {
                      context.pushRoute(
                        AskForVolunteersRouter(
                          chapterMeetingId: widget.chapterMeetingId,
                          viewMode: true,
                        ),
                      );
                    },
                    onIconButtonTap: () async {},
                    title: "testing tilte 1 ",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  announcementCard(
                    description: "Description test 2",
                    onCardTap: () {
                      context.pushRoute(
                        AnnounceChapterMeetingRouter(),
                      );
                    },
                    onIconButtonTap: () async {},
                    title: "testing tilte 2 ",
                  ),
                ],
              ),
              filledTextButton(callBack: () {}, content: "Announce Chapter"),
            ],
          ),
        ),
      ),
    );
  }
}
