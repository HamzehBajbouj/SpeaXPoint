import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/manage_roles_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/manage_role_players/dialogs/end_session_confirmation_dialog.dart';

class ManageRolesPlayersView extends StatefulWidget {
  final String chapterMeetingId;
  const ManageRolesPlayersView({
    super.key,
    required this.chapterMeetingId,
  });

  @override
  State<ManageRolesPlayersView> createState() => _ManageRolePlayersViewState();
}

class _ManageRolePlayersViewState extends State<ManageRolesPlayersView> {
  ManageRolesPlayersViewModel? _manageRolesPlayersViewModel;
  late Timer _timer;
  String _formattedTime = '00:00:00';

  @override
  void initState() {
    super.initState();

    _manageRolesPlayersViewModel =
        Provider.of<ManageRolesPlayersViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String hours = (duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void _startTimer(DateTime startTime) {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _formattedTime = _formatTime(DateTime.now().difference(startTime));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<int>(
                stream: _manageRolesPlayersViewModel!.getNumberOfOnlinePeople(
                    chapterMeetingId: widget.chapterMeetingId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int onlinePeople = snapshot.data!;
                    return generalMeetingGeneralInfo(
                        title: "Online People",
                        content: onlinePeople.toString());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Loading Online People Number ...',
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<DateTime>(
                future: _manageRolesPlayersViewModel!
                    .getLaunchTime(chapterMeetingId: widget.chapterMeetingId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _startTimer(snapshot.data!);
                    return generalMeetingGeneralInfo(
                        title: "Session Time", content: _formattedTime);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Loading Session Time ...',
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Chapter Meeting Speeches",
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p90),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Select the speaker card to start his/her speech, by selecting the speaker card, the speaker evaluation will start.",
            maxLines: 3,
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p50),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<List<OnlineSessionCapturedData>>(
              stream: _manageRolesPlayersViewModel!.getListOfSpeaches(
                chapterMeetingId: widget.chapterMeetingId,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(AppMainColors.p40),
                    ),
                  );
                } else {
                  final List<OnlineSessionCapturedData> items = snapshot.data!;

                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        "You have not announced any volunteers requests.",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        return speechCardDetails(
                          role: items[index].roleName!,
                          rolePlace: items[index].roleOrderPlace,
                          selectSpeechTurn: () async {
                            await _manageRolesPlayersViewModel!
                                .selectSpeakerSpeechFromTheList(
                              chapterMeetingId: items[index].chapterMeetingId!,
                              isAnAppGuest: items[index].isAnAppGuest!,
                              chapterMeetingInvitationCode:
                                  items[index].chapterMeetingInvitationCode,
                              guestInvitationCode:
                                  items[index].guestInvitationCode,
                              toastmasterId: items[index].toastmasterId,
                            );
                          },
                          speakerName: items[index].speakerName!,
                          cardColor: getSpeechCardColor(
                              items[index].onlineSessionSpeakerTurn!),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
          outlinedButton(
              callBack: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EndSessionConfirmationDialog(
                      chapterMeetingId: widget.chapterMeetingId,
                    );
                  },
                ).then(
                  (value) async {
                    if (value != null && (value as bool == true)) {
                      context.router.popForced();
                    }
                  },
                );
              },
              content: "End The Session",
              buttonColor: const Color(AppMainColors.warningError50)),
        ],
      ),
    );
  }

  Color getSpeechCardColor(String selectionStatus) {
    switch (selectionStatus) {
      case "CurrentlySelected":
        return const Color(AppMainColors.volunteerAcceptedApplicantStatus);
      case "WasSelected":
        return const Color(AppMainColors.volunteerPendingApplicantStatus);
      case "NotSelected":
        return const Color(AppMainColors.volunteerNoApplicantStatus);

      default:
        return const Color(AppMainColors.warningError75);
    }
  }

  Widget generalMeetingGeneralInfo(
      {required String title, required String content}) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 30,
        maxHeight: 40,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(AppMainColors.p40),
          width: 1.3,
        ),
        borderRadius:
            BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p50),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                content,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(AppMainColors.p50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
