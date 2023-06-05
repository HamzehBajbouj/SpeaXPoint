import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/online_session_captured_data.dart';
import 'package:speaxpoint/models/time_filler_captured_data.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/time_filler_view_model.dart';

class TimeFillerNotes extends StatefulWidget {
  const TimeFillerNotes({
    super.key,
    required this.isAGuest,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestInvitationCode,
    this.toastmasterId,
  });
  final bool isAGuest;
  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final String? guestInvitationCode;
  final String? toastmasterId;
  @override
  State<TimeFillerNotes> createState() => _TimeFillerNotesState();
}

class _TimeFillerNotesState extends State<TimeFillerNotes> {
  TimeFillerViewModel? _timeFillerViewModel;

  bool _isLoadingRequest2 = true;
  OnlineSessionCapturedData? _selectedSpeechSpeaker;
  late List<OnlineSessionCapturedData> _speechesSpeakersList;
  @override
  void initState() {
    super.initState();
    _timeFillerViewModel =
        Provider.of<TimeFillerViewModel>(context, listen: false);

    getListOfSpeechesSpeakers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Time Fillers Notes",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p90),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            _isLoadingRequest2
                ? const Text(
                    "Loading...",
                    style: TextStyle(
                      height: 1.4,
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p70),
                    ),
                  )
                : textButtonWithTrailingIcon(
                    callBack: () {
                      displaySpeechesSpeakersDropMenu(
                        context: context,
                        dataList: generateSelectedListItems(
                          choices: _speechesSpeakersList
                              .map((data) => data.speakerName!)
                              .toList(),
                          indexes: List.generate(
                              _speechesSpeakersList.length, (index) => index),
                        ),
                        selectedItemsCallBack: (selectedItemsList) {
                          SelectedListItem? tempItem;
                          for (var item in selectedItemsList) {
                            if (item is SelectedListItem) {
                              tempItem = item;
                            }
                          }
                          setState(
                            () {
                              _selectedSpeechSpeaker = _speechesSpeakersList[
                                  int.parse(tempItem!.value!)];
                            },
                          );
                        },
                      );
                    },
                    content: Text(
                      _selectedSpeechSpeaker == null
                          ? "Select Speaker"
                          : _selectedSpeechSpeaker!.speakerName!,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color(AppMainColors.p80),
                          fontFamily: CommonUIProperties.fontType,
                          fontWeight: FontWeight.normal),
                    ),
                    trailingIcon: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Color(AppMainColors.p20),
                    ),
                  ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        _selectedSpeechSpeaker == null
            ? Container()
            : FutureBuilder(
                future: _timeFillerViewModel!.getTimeFillerDetails(
                  chapterMeetingId: widget.chapterMeetingId,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                  currentSpeakerisAppGuest:
                      _selectedSpeechSpeaker!.isAnAppGuest!,
                  currentSpeakerGuestInvitationCode:
                      _selectedSpeechSpeaker!.guestInvitationCode,
                  currentSpeakerToastmasterId:
                      _selectedSpeechSpeaker!.toastmasterId,
                ),
                builder: (
                  context,
                  AsyncSnapshot<Map<String, List<TimeFillerCapturedData>>>
                      snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(AppMainColors.p40),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var dd = snapshot.data!;

                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            "Tesr",
                          ),
                        ),
                      );
                    } else {
                      return const Text(
                          "Error: unable to fetch applicant details");
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
      ],
    );
  }

  Future<void> getListOfSpeechesSpeakers() async {
    _speechesSpeakersList = await _timeFillerViewModel!
        .getListOfSpeechesSpeakers(
            isAGuest: widget.isAGuest,
            chapterMeetingId: widget.chapterMeetingId,
            chapterMeetingInvitationCode: widget.chapterMeetingInvitationCode,
            guestInvitationCode: widget.guestInvitationCode,
            toastmasterId: widget.toastmasterId)
        .whenComplete(
      () {
        setState(
          () {
            _isLoadingRequest2 = false;
          },
        );
      },
    );
  }
}
