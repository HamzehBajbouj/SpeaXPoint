import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_chapter_meeting_announcement_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_chapter_meeting_announcements/dialogs/announce_chapter_error_dialog.dart';

class ManageChapterMeetingAnnouncementsScreen extends StatefulWidget {
  const ManageChapterMeetingAnnouncementsScreen(
      {super.key, required this.chapterMeetingId, required this.clubId});
  final String chapterMeetingId;
  final String clubId;

  @override
  State<ManageChapterMeetingAnnouncementsScreen> createState() =>
      _ManageChapterMeetingAnnouncementsScreenState();
}

class _ManageChapterMeetingAnnouncementsScreenState
    extends State<ManageChapterMeetingAnnouncementsScreen> {
  late ManageChapterMeetingAnnouncementViewModel _manageAnnouncementVM;

  @override
  void initState() {
    super.initState();
    _manageAnnouncementVM =
        Provider.of<ManageChapterMeetingAnnouncementViewModel>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    //always set it to initial when loading this page , as its data are kept,
    //even after we exist the page.
    _manageAnnouncementVM.meetingAgendaStatus = true;

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
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
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
                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _manageAnnouncementVM.loadAllAnnouncements(
                        chapterMeetingId: widget.chapterMeetingId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(AppMainColors.p40),
                          ),
                        );
                      } else {
                        final List<Map<String, dynamic>> items = snapshot.data!;
                        _manageAnnouncementVM.setAnnouncementObject(items);
                        if (items.isEmpty) {
                          return const SizedBox(
                            height: 150,
                            child: Center(
                              child: Text(
                                "You Currently Don't Have Any Announcements "
                                "Click on Announce Chapter To Create One!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p50),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Consumer<
                              ManageChapterMeetingAnnouncementViewModel>(
                            builder: (_, viewModel, child) {
                              return Column(
                                children: [
                                  if (viewModel.volunteerAnnouncement != null)
                                    announcementCard(
                                      title: viewModel.volunteerAnnouncement
                                              ?.annoucementTitle ??
                                          "no title provided",
                                      description: viewModel
                                              .volunteerAnnouncement
                                              ?.annoucementDescription ??
                                          "no description provided",
                                      onCardTap: () {
                                        context.pushRoute(
                                          AskForVolunteersRouter(
                                            chapterMeetingId:
                                                widget.chapterMeetingId,
                                            viewMode: true,
                                            clubId: widget.clubId,
                                          ),
                                        );
                                      },
                                      onIconButtonTap: () async {
                                        await viewModel
                                            .deleteAnExistingAnnouncement(
                                                chapterMeetingId:
                                                    widget.chapterMeetingId,
                                                announcementType:
                                                    AnnouncementType
                                                        .VolunteersAnnouncement
                                                        .name);
                                      },
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (viewModel.chapterMeetingAnnouncement !=
                                      null)
                                    announcementCard(
                                      title: viewModel
                                              .chapterMeetingAnnouncement
                                              ?.meetingTtile ??
                                          "no title provided",
                                      description: viewModel
                                              .chapterMeetingAnnouncement
                                              ?.meetingDescription ??
                                          "no description provided",
                                      onCardTap: () {
                                        context.pushRoute(
                                          AnnounceChapterMeetingRouter(),
                                        );
                                      },
                                      onIconButtonTap: () async {
                                        await viewModel
                                            .deleteAnExistingAnnouncement(
                                                chapterMeetingId:
                                                    widget.chapterMeetingId,
                                                announcementType: AnnouncementType
                                                    .ChapterMeetingAnnouncement
                                                    .name);
                                      },
                                    ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
              Consumer<ManageChapterMeetingAnnouncementViewModel>(
                builder: (_, viewModel, child) {
                  return filledTextButton(
                      callBack: () async {
                        //sholw
                        if (_manageAnnouncementVM.canAnnounce()) {
                          //here check if all role are allocated
                          await _manageAnnouncementVM
                              .validateMeetingAgenda(
                                  chapterMeetingId: widget.chapterMeetingId)
                              .then(
                            (value) {
                              if (viewModel.meetingAgendaStatus) {
                                context.pushRoute(
                                  const AnnounceChapterMeetingRouter(),
                                );
                                // context.pushRoute();
                              }
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AnnounceChapterErrorDialog();
                            },
                          );
                        }
                      },
                      content: "Announce Chapter");
                },
              ),
              Consumer<ManageChapterMeetingAnnouncementViewModel>(
                builder: (_, viewModel, child) {
                  if (viewModel.meetingAgendaStatus) {
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Warning ! ',
                            style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                color: Color(AppMainColors.warningError75),
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: viewModel.meetingAgendaWarningMessage,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
