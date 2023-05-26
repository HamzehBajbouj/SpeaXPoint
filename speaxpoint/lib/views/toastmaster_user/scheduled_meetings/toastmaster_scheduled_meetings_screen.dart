import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/scheduled_meetings_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/scheduled_meetings/dialogs/join_session_confirmation_dialog.dart';
import 'dialogs/launch_session_confirmation_dialog.dart';

class ToastmasterScheduledMeetingsScreen extends StatefulWidget {
  const ToastmasterScheduledMeetingsScreen({super.key});

  @override
  State<ToastmasterScheduledMeetingsScreen> createState() =>
      _ToastmasterScheduledMeetingsScreenState();
}

class _ToastmasterScheduledMeetingsScreenState
    extends State<ToastmasterScheduledMeetingsScreen> {
  ScheduledMeetingsViewModel? _scheduledMeetingsViewModel;
  String currentMemberClubRole = "";

  @override
  void initState() {
    super.initState();
    _scheduledMeetingsViewModel =
        Provider.of<ScheduledMeetingsViewModel>(context, listen: false);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentMemberClubRole =
        await _scheduledMeetingsViewModel!.getDataFromLocalDataBase(
      keySearch: "memberOfficalRole",
    );
  }

  Future<void> refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Scheduled Meetings",
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
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: FutureBuilder<List<ChapterMeeting>>(
              future:
                  _scheduledMeetingsViewModel!.getScheduledChapterMeetings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error occurred'),
                  );
                } else {
                  final List<ChapterMeeting> chapterMeetings =
                      snapshot.data ?? [];
                  if (chapterMeetings.isEmpty) {
                    return const Center(
                      child: Text(
                        "You Don't Have Any Scheduled Meetings",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: chapterMeetings.length,
                      separatorBuilder: (_, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(0),
                          elevation: 0,
                          color: getCardColor(
                              chapterMeetings[index].chapterMeetingStatus!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonUIProperties.cardRoundedEdges),
                          ),
                          child: ListTile(
                              onTap: () {
                                context.pushRoute(
                                  ViewScheduledMeetingDetailsRouter(
                                      chapterMeetingId: chapterMeetings[index]
                                          .chapterMeetingId!),
                                );
                              },
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 5,
                                bottom: 5,
                              ),
                              title: Text(
                                chapterMeetings[index].chapterTitle!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppMainColors.p80),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    DateFormat("h:mm a, EEEE, MMM d, yyyy")
                                        .format(DateTime.parse(
                                            chapterMeetings[index]
                                                .dateOfMeeting!)),
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p50),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: chapterMeetings[index]
                                          .chapterMeetingStatus! ==
                                      ComingSessionsStatus.Coming.name
                                  ? Visibility(
                                      visible: currentMemberClubRole ==
                                          ToastmasterRoles
                                              .Vice_President_Education.name
                                              .replaceAll("_", " "),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return LaunchSessionConfirmationDialog(
                                                chapterMeetingId:
                                                    chapterMeetings[index]
                                                        .chapterMeetingId!,
                                              );
                                            },
                                          ).then(
                                            (value) async {
                                              if (value != null &&
                                                  (value as bool == true)) {
                                                refreshData().then(
                                                  (_) {
                                                    context.router.push(
                                                      SessionRedirectionRouter(
                                                        chapterMeetingId:
                                                            chapterMeetings[
                                                                    index]
                                                                .chapterMeetingId!,
                                                        isAGuest: false,
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        },
                                        child: Container(
                                          constraints: const BoxConstraints(
                                            maxWidth: 70,
                                            maxHeight: 30,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(AppMainColors
                                                .backgroundAndContent),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Launch",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    CommonUIProperties.fontType,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(AppMainColors.p80),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return JoinSessionConfirmationDialog(
                                              chapterMeetingId:
                                                  chapterMeetings[index]
                                                      .chapterMeetingId!,
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 70,
                                          maxHeight: 30,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color(AppMainColors
                                              .backgroundAndContent),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Join",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  CommonUIProperties.fontType,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(AppMainColors.p80),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    getCardTrailingIcon(chapterMeetings[index]
                                        .chapterMeetingStatus!),
                                    color: getCardIconColor(
                                        chapterMeetings[index]
                                            .chapterMeetingStatus!),
                                    size: 29,
                                  ),
                                  Text(
                                    chapterMeetings[index]
                                        .chapterMeetingStatus!,
                                    style: TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 11,
                                      fontWeight: FontWeight.normal,
                                      color: getCardIconColor(
                                          chapterMeetings[index]
                                              .chapterMeetingStatus!),
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
