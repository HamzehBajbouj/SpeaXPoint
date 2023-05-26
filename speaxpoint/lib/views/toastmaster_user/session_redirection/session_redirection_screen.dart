import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/session_redirection_view_model.dart';

class SessionRedirectionScreen extends StatefulWidget {
  const SessionRedirectionScreen({
    super.key,
    required this.isAGuest,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestHasRole,
    this.guestInvitationCode,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;
  final bool? guestHasRole;
  final String? guestInvitationCode;

  @override
  State<SessionRedirectionScreen> createState() =>
      _SessionRedirectionScreenState();
}

class _SessionRedirectionScreenState extends State<SessionRedirectionScreen> {
  SessionRedirectionViewModel? _sessionRedirectionViewModel;

  @override
  void initState() {
    super.initState();
    _sessionRedirectionViewModel =
        Provider.of<SessionRedirectionViewModel>(context, listen: false);
  }

  void redirectToastmasterToTargetScreen({
    required BuildContext context,
    required String roleName,
  }) {
    switch (roleName) {
      case "Timer":
        context.router.replace(TimeSpeakerRouter());
        break;
      case "Speaker":
        context.router.replace(SpeakerObservedDataRouter());
        break;
      case "Ah Counter":
        context.router.replace(CountTimeFillersRouter());
        break;
      case "Grammarian":
        context.router.replace(ObserveGrammarianMistakesRouter());
        break;
      case "Speach Evaluator":
        context.router.replace(ManageEvaluationRouter());
        break;
      case "General Evaluator":
        context.router.replace(ManageEvaluationRouter());
        break;
      //this one is no need for it, because if the user was VPE it will be two tabs,
      // case "Toastmaster":
      //   context.router.replace(ManageRolePlayersRouter());
      // break;
      case "MeetingVisitor":
        context.router.replace(SessionWaitingRouter());
        break;
      default:
        context.router.replace(SessionWaitingRouter());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: FutureBuilder<String>(
        future: _sessionRedirectionViewModel!.getTargetScreen(
          isAGuest: widget.isAGuest,
          chapterMeetingId: widget.chapterMeetingId,
          chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
          guestHasRole: widget.guestHasRole,
          guestInvitationCode: widget.guestInvitationCode,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Error occurred, navigate to Screen C

            return Container(); // Return an empty container while navigating
          } else {
            String isUserAuthenticated = snapshot.data ?? "dffd";
            redirectToastmasterToTargetScreen(
                context: context, roleName: isUserAuthenticated);
            return Center(
              child: Container(
                child: Text(" It works : $isUserAuthenticated"),
              ),
            ); // Return an empty container while navigating
          }
        },
      ),
    );
  }
}
