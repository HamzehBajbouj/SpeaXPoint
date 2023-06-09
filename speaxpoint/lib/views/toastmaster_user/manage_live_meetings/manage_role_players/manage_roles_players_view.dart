import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
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
  bool _selectionSpeechButtonIsEnable = true;

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
                    return generalMeetingGeneralInfoCard(
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
                future: _manageRolesPlayersViewModel!.getLaunchTime(
                  chapterMeetingId: widget.chapterMeetingId,
                  //false since he is the VPE of education so he is always an app guest
                  //and no need to pass anything from the other screen via the constructors
                  isAnAppGuest: false,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _startTimer(snapshot.data!);
                    return generalMeetingGeneralInfoCard(
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
                        "There Is No Any Speaches For This Session!.",
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
                          iconButtonActionIsEnabled:
                              _selectionSpeechButtonIsEnable,
                          role: items[index].roleName!,
                          rolePlace: items[index].roleOrderPlace,
                          selectSpeechTurn: () async {
                            // to have a delay time between consecutive button clicks
                            //to prevent any issue in the database or race-conditions
                            if (_selectionSpeechButtonIsEnable) {
                              setState(() {
                                _selectionSpeechButtonIsEnable = false;
                              });

                              await _manageRolesPlayersViewModel!
                                  .selectSpeakerSpeechFromTheList(
                                chapterMeetingId:
                                    items[index].chapterMeetingId!,
                                isAnAppGuest: items[index].isAnAppGuest!,
                                chapterMeetingInvitationCode:
                                    items[index].chapterMeetingInvitationCode,
                                guestInvitationCode:
                                    items[index].guestInvitationCode,
                                toastmasterId: items[index].toastmasterId,
                              )
                                  .then(
                                (_) {
                                  setState(() {
                                    _selectionSpeechButtonIsEnable = true;
                                  });
                                },
                              );
                            }
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
    void _startTimer(DateTime startTime) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _formattedTime = formatTime(DateTime.now().difference(startTime));
      });
    });
  }
}
