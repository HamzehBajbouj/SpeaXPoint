import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/manage_roles_players_view_model.dart';

class SessionWaitingView extends StatefulWidget {
  const SessionWaitingView({
    super.key,
    required this.isAGuest,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
  });
  final String? chapterMeetingId;
  final bool isAGuest;
  final String? chapterMeetingInvitationCode;

  @override
  State<SessionWaitingView> createState() => _SessionWaitingScreenState();
}

class _SessionWaitingScreenState extends State<SessionWaitingView> {
  OnlineSession _onlineSessionDetails = OnlineSession();
  ManageRolesPlayersViewModel? _manageRolesPlayersViewModel;
  late Timer _timer;
  String _formattedTime = '00:00:00';
  bool _isLoadingRequest1 = true;
  @override
  void initState() {
    super.initState();

    _manageRolesPlayersViewModel =
        Provider.of<ManageRolesPlayersViewModel>(context, listen: false);

    _manageRolesPlayersViewModel!
        .getOnlineSessionDetails(
            isAnAppGuest: widget.isAGuest,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            chapterMeetingId: widget.chapterMeetingId)
        .listen((data) {
      setState(() {
        _onlineSessionDetails = data;
        _isLoadingRequest1 = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingRequest1
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(AppMainColors.p40),
            ),
          )
        : Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    fit: BoxFit.fill,
                    "assets/images/happy_music.svg",
                    allowDrawingOutsideViewBox: false,
                    // width: 200,
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder<DateTime>(
                  future: _manageRolesPlayersViewModel!.getLaunchTime(
                    chapterMeetingId: widget.chapterMeetingId,
                    isAnAppGuest: widget.isAGuest,
                    chapterMeetingInvitationCode:
                        widget.chapterMeetingInvitationCode,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _startTimer(snapshot.data!);

                      return sessionTimeCounter(
                          title: "Session Time", content: _formattedTime);
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return sessionTimeCounter(
                          title: "Session Time", content: "00:00:00");
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                generalMeetingGeneralInfoCard(
                  title: "Online People",
                  content:
                      _onlineSessionDetails.numberOfJoinedPeople.toString(),
                ),
                const SizedBox(
                  height: 15,
                ),
                generalMeetingGeneralInfoCard(
                  title: "Current Speaker",
                  content: _onlineSessionDetails.thereIsSelectedSpeaker! &&
                          _onlineSessionDetails.currentSpeakerName != null
                      ? _onlineSessionDetails.currentSpeakerName!
                      : "No Speaker Yet!",
                ),
              ],
            ),
          );
  }

  void _startTimer(DateTime startTime) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _formattedTime = formatTime(DateTime.now().difference(startTime));
      });
    });
  }

  Widget sessionTimeCounter({required String content, required String title}) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            content,
            style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 50,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p90),
              letterSpacing: 8,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p50),
            ),
          ),
        ],
      ),
    );
  }
}
