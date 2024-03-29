import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/no_agenda_yet_view.dart';
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/time_line_tile_item.dart';

class PrepareMeetingAgendaScreen extends StatefulWidget {
  const PrepareMeetingAgendaScreen({super.key, required this.chapterMeetingId});
  final String chapterMeetingId;

  @override
  State<PrepareMeetingAgendaScreen> createState() =>
      _PrepareMeetingAgendaScreenState();
}

class _PrepareMeetingAgendaScreenState
    extends State<PrepareMeetingAgendaScreen> {
  late PrepareMeetingAgendaViewModel _prepareMeetingAgendaViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _prepareMeetingAgendaViewModel =
        Provider.of<PrepareMeetingAgendaViewModel>(context);
  }

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
          "Prepare Meeting Agenda",
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
          padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
          child: StreamBuilder<List<MeetingAgenda>>(
            stream: _prepareMeetingAgendaViewModel
                .getChapterMeetingAgenda(widget.chapterMeetingId),
            builder: (context, AsyncSnapshot<List<MeetingAgenda>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(AppMainColors.p40),
                  ),
                );
              } else {
                //getList of the meeting agendaDate
                final List<MeetingAgenda> items = snapshot.data!;
                //obtain the set the data of fetched from the stream
                //we need to set so we later can get a reference to the stram list element
                //and get the latest unique agenda card id
                _prepareMeetingAgendaViewModel.meetingAgendaList =
                    snapshot.data!;
                if (_prepareMeetingAgendaViewModel.meetingAgendaList.isEmpty) {
                  return NoAgendaYetView(
                      chapterMeetingId: widget.chapterMeetingId);
                } else {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Your Chapter Meeting Agenda",
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(AppMainColors.p90),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await _prepareMeetingAgendaViewModel
                                  .addNewAgendaEmptyCard(
                                      widget.chapterMeetingId);
                            },
                            child: Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(AppMainColors.p5),
                                shape: BoxShape.rectangle,
                              ),
                              child: const Center(
                                child: Text(
                                  "Add +",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p80),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Click on the card to edit its details, click on add button to create a add ticket.",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<PrepareMeetingAgendaViewModel>(
                        builder: (_, viewModel, child) {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, int index) {
                                return TimeLineTileItem(
                                  chapterMeetingId: widget.chapterMeetingId,
                                  meetingAgnedaCard: items[index],
                                  isFirst: index == 0 ? true : false,
                                  isLast: index == (items.length - 1)
                                      ? true
                                      : false,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
