import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/annoucement/chapter_meeting_announcement.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_chapter_meeting_announcement_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ChapterMeetingAnnouncementViewScreen extends StatelessWidget {
  const ChapterMeetingAnnouncementViewScreen(
      {super.key,
      required this.chapterMeetingId,
      required this.viewedFromSearchPage,
      required this.clubId});

  final String chapterMeetingId;
  final bool viewedFromSearchPage;
  final String clubId;
  @override
  Widget build(BuildContext context) {
    final ManageChapterMeetingAnnouncementViewModel manageAnnouncementVM =
        Provider.of<ManageChapterMeetingAnnouncementViewModel>(context,
            listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(AppMainColors.p70),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Announcement Details",
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
          child: FutureBuilder(
            future: manageAnnouncementVM.getChapterMeetingAnnouncementDetails(
                chapterMeetingId: chapterMeetingId),
            builder: (
              context,
              AsyncSnapshot<ChapterMeetingAnnouncement?> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(AppMainColors.p40),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return snapshot.data == null
                      ? const Center(
                          child: Text(
                            "There are no details provided for this announcement",
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
                              color: Color(AppMainColors.p50),
                            ),
                          ),
                        )
                      : Center(
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    CommonUIProperties.buttonRoundedEdges),
                                color: const Color(AppMainColors
                                    .announcementDetailsCardBackground),
                                border: Border.all(
                                  color: const Color(AppMainColors.p40),
                                  width: 1.3,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Visibility(
                                    visible: snapshot
                                            .data!.brushureLink?.isNotEmpty ??
                                        false,
                                    child: SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        child: Image.network(
                                          snapshot.data!.brushureLink ?? " ",
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          snapshot.data!.annoucementTitle ??
                                              "No Title Is Provided!",
                                          style: const TextStyle(
                                            fontFamily:
                                                CommonUIProperties.fontType,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(AppMainColors.p80),
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          snapshot.data!
                                                  .annoucementDescription ??
                                              "No Description Is Provided!",
                                          style: const TextStyle(
                                            fontFamily:
                                                CommonUIProperties.fontType,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Color(AppMainColors.p50),
                                          ),
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Meeting Date',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          CommonUIProperties
                                                              .fontType,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(
                                                          AppMainColors.p80),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      snapshot.data!
                                                                  .meetingDate !=
                                                              null
                                                          ? DateFormat(
                                                                  "E, d MMM, h:mm a")
                                                              .format(
                                                              DateTime.parse(
                                                                  snapshot.data!
                                                                      .meetingDate!),
                                                            )
                                                          : "No Date Is Provided",
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            CommonUIProperties
                                                                .fontType,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Color(
                                                            AppMainColors.p50),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Visibility(
                                              visible: snapshot
                                                      .data!
                                                      .contactNumber
                                                      ?.isNotEmpty ??
                                                  false,
                                              child: Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Contact Number',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            CommonUIProperties
                                                                .fontType,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                            AppMainColors.p80),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      // child:
                                                      child: GestureDetector(
                                                        child: Text(
                                                          snapshot.data!
                                                                  .contactNumber ??
                                                              "Mo Contact Number Is Provided",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  CommonUIProperties
                                                                      .fontType,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .blueAccent,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                        onTap: () async {
                                                          final url = Uri.parse(
                                                              'tel:${snapshot.data!.contactNumber ?? "0000"}');
                                                          if (await canLaunchUrl(
                                                              url)) {
                                                            launchUrl(url);
                                                          } else {
                                                            log("Can't launch $url");
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: snapshot
                                                  .data!
                                                  .meetingStreamLink
                                                  ?.isNotEmpty ??
                                              false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 15),
                                              const Text(
                                                'Meeting Link',
                                                style: TextStyle(
                                                  fontFamily: CommonUIProperties
                                                      .fontType,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Color(AppMainColors.p80),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                child: const Text(
                                                  'Click here to open the link',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        CommonUIProperties
                                                            .fontType,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueAccent,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  final url = Uri.parse(snapshot
                                                          .data!
                                                          .meetingStreamLink ??
                                                      " ");
                                                  if (await canLaunchUrl(url)) {
                                                    launchUrl(url);
                                                  } else {
                                                    log("Can't launch $url");
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Visibility(
                                          visible: viewedFromSearchPage,
                                          child: Column(
                                            children: [
                                              outlinedButton(
                                                buttonHeight: 40,
                                                callBack: () {},
                                                content: "View Club Profile",
                                              ),
                                              const SizedBox(height: 15),
                                              outlinedButton(
                                                buttonHeight: 40,
                                                callBack: () {},
                                                content: "Add To Schedule",
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                } else {
                  return const Text(
                      "Error: unable to fetch announcement details");
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
          ),
        ),
      ),
    );
  }
}
