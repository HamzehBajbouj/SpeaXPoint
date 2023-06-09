import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/util/constants/api_common_value.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/session_redirection_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/count_time_fillers/count_time_fillers_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/manage_evaluation/manage_general_evaluation_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/manage_evaluation/manage_speech_evaluation_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/manage_role_players/vpe_manage_role_players_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/observe_grammarian_mistakes/observe_grammarian_mistakes_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/speaker_observed_data/speaker_observed_data_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/time_speaker/time_speaker_view.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_live_meetings/waiting_page/session_waiting_view.dart';
import 'package:speaxpoint/views/toastmaster_user/session_redirection/exit_redirection_screen_confirmation_dialog.dart';
import 'package:speaxpoint/views/toastmaster_user/session_redirection/session_completion_counter_dialog.dart';

class SessionRedirectionScreen extends StatefulWidget {
  const SessionRedirectionScreen({
    super.key,
    required this.isAGuest,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestHasRole,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final bool? guestHasRole;
  final String? guestInvitationCode;
  final String? toastmasterId;

  @override
  State<SessionRedirectionScreen> createState() =>
      _SessionRedirectionScreenState();
}

class _SessionRedirectionScreenState extends State<SessionRedirectionScreen> {
  SessionRedirectionViewModel? _sessionRedirectionViewModel;
  String currentMemberClubRole = "";

  @override
  void initState() {
    super.initState();
    _sessionRedirectionViewModel =
        Provider.of<SessionRedirectionViewModel>(context, listen: false);

  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentMemberClubRole =
        await _sessionRedirectionViewModel!.getDataFromLocalDataBase(
      keySearch: "memberOfficalRole",
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: const Color(AppMainColors.backgroundAndContent),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 20,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                StreamBuilder<ChapterMeeting>(
                  stream: _sessionRedirectionViewModel!
                      .getChapterMeetingLiveDetails(
                    isAppGuest: widget.isAGuest,
                    chapterMeetingId: widget.chapterMeetingId,
                    chapterMeetingInvitationCode:
                        widget.chapterMeetingInvitationCode,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      ChapterMeeting chapterMeeting = snapshot.data!;
                      if (chapterMeeting.chapterMeetingStatus != null &&
                          chapterMeeting.chapterMeetingStatus! ==
                              ComingSessionsStatus.Completed.name) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const SessionCompletionCounterDialog();
                            },
                          ).then((value) {
                            context.router.popForced();
                          });
                        });
                      }

                      return Container();
                    } else {
                      return const Text(
                        'Countdown Ended',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
                Expanded(
                  child: FutureBuilder<String>(
                    future: _sessionRedirectionViewModel!
                        .getTargetScreen(
                          isAGuest: widget.isAGuest,
                          chapterMeetingId: widget.chapterMeetingId,
                          chapterMeetingInvitationCode:
                              widget.chapterMeetingInvitationCode,
                          guestHasRole: widget.guestHasRole,
                          guestInvitationCode: widget.guestInvitationCode,
                        )
                        .timeout(
                          const Duration(
                            seconds: APICommonValues.requestTimeoutInSeconds,
                          ),
                        ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Color(AppMainColors.p40),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Redirecting You Into Your Corresponding Role Screen",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(AppMainColors.p70),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return timeoutErrorMessage(
                          errorType: snapshot.error,
                          firstMessage:
                              "Request Timeout Erorr While Redirecting You To Your Corresponding Role Screen."
                              "\nPlease Check Your Internet Connection",
                          secondMessage:
                              "An Error Happened while Redirecting You To Your Corresponding Role Screen.",
                        );
                      } else {
                        String roleName = snapshot.data ?? "ErrorNoData";

                        if (roleName != "ErrorNoData") {
                          if (currentMemberClubRole ==
                              ToastmasterRoles.Vice_President_Education.name
                                  .replaceAll("_", " ")) {
                            //check if we are speaker/Toastmaster OTE
                            //if so since the roleName will be displayed on the tabView
                            //in the VPEManageRolePlayersScreen , change its name
                            if (roleName == "Speaker" ||
                                roleName == "Toastmaster OTE") {
                              roleName = "Speech Observations";
                            }
                            return VPEManageRolePlayersScreen(
                              chapterMeetingId: widget.chapterMeetingId!,
                              roleName: roleName,
                              roleView: redirectToastmasterToTargetScreen(
                                isAGuest: widget.isAGuest,
                                roleName: roleName,
                                chapterMeetingId: widget.chapterMeetingId,
                                chapterMeetingInvitationCode:
                                    widget.chapterMeetingInvitationCode,
                                guestInvitationCode: widget.guestInvitationCode,
                                toastmasterId: widget.toastmasterId,
                              ),
                            );
                          } else {
                            return redirectToastmasterToTargetScreen(
                              isAGuest: widget.isAGuest,
                              roleName: roleName,
                              chapterMeetingId: widget.chapterMeetingId,
                              chapterMeetingInvitationCode:
                                  widget.chapterMeetingInvitationCode,
                              guestInvitationCode: widget.guestInvitationCode,
                              toastmasterId: widget.toastmasterId,
                            );
                          }
                        } else {
                          return const Center(
                            child: Text(
                              "ERORR: No Data is Received Regarding Role Name..",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(AppMainColors.warningError50),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ExitRedirectionScreenConfirmationDialog(
              isAGuest: widget.isAGuest,
              chapterMeetingId: widget.chapterMeetingId,
              chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            );
          },
        ) ??
        false;
  }

  Widget redirectToastmasterToTargetScreen({
    required String roleName,
    required bool isAGuest,
    String? chapterMeetingId,
    String? guestInvitationCode,
    String? chapterMeetingInvitationCode,
    String? toastmasterId,
  }) {
    switch (roleName) {
      case "Timer":
        return TimeSpeakerView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "Speaker":
        return SpeakerObservedDataViwe(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "Ah Counter":
        return CountTimeFillersView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "Grammarian":
        return ObserveGrammarianMistakesView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "Speach Evaluator":
        return ManageSpeechEvaluationView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "General Evaluator":
        return ManageGeneralEvaluationView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "Toastmaster OTE":
        return SpeakerObservedDataViwe(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          guestInvitationCode: guestInvitationCode,
          toastmasterId: toastmasterId,
        );
      case "MeetingVisitor":
        return SessionWaitingView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
        );
      default:
        return SessionWaitingView(
          isAGuest: isAGuest,
          chapterMeetingId: chapterMeetingId,
          chapterMeetingInvitationCode: chapterMeetingInvitationCode,
        );
    }
  }
}
