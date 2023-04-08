import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/meeting_agenda.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/edit_ticket_bottom_sheet.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineTileItem extends StatefulWidget {
  const TimeLineTileItem({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.chapterMeetingId,
    required this.meetingAgnedaCard,
  });

  final bool isFirst;
  final bool isLast;
  final String chapterMeetingId;
  final MeetingAgneda meetingAgnedaCard;

  @override
  State<TimeLineTileItem> createState() => _TimeLineTileItemState();
}

class _TimeLineTileItemState extends State<TimeLineTileItem> {
  late PrepareMeetingAgendaViewModel _prepareMeetingAgendaViewModel;

  @override
  void initState() {
    // TODO: implement initState
    _prepareMeetingAgendaViewModel =
        Provider.of<PrepareMeetingAgendaViewModel>(context, listen: false);
  }

  // String _updatedTime = "";
  // bool valuePassedFirstTime = true;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: widget.isFirst,
      isLast: widget.isLast,
      alignment: TimelineAlign.start,
      indicatorStyle: IndicatorStyle(
        width: 24,
        height: 24,
        indicator: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(AppMainColors.p60),
              width: 2.3,
            ),
            shape: BoxShape.circle,
            color: const Color(AppMainColors.p40),
          ),
        ),
        padding: const EdgeInsets.only(
          right: 15,
        ),
      ),
      beforeLineStyle: const LineStyle(
        thickness: 3.6,
        color: Color(AppMainColors.p60),
      ),
      afterLineStyle: const LineStyle(
        thickness: 3.6,
        color: Color(AppMainColors.p60),
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 50,
            maxHeight: 60,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(AppMainColors.p60),
              width: 1.3,
            ),
            borderRadius:
                BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  DatePicker.showTime12hPicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (data) async {
                      await _prepareMeetingAgendaViewModel.updateTimeSequence(
                        agendaCardNumber:
                            widget.meetingAgnedaCard.agendaCardOrder ?? -1,
                        chapterMeetingId: widget.chapterMeetingId,
                        timeSequence: DateFormat("h:mm a").format(data),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(maxWidth: 60),
                  child: Center(
                    child: Text(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      widget.meetingAgnedaCard.timeSequence ?? "TIME",
                      style: const TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p70),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: 1,
                color: const Color(AppMainColors.p60),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showMaterialModalBottomSheet(
                      backgroundColor:
                          const Color(AppMainColors.backgroundAndContent),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              CommonUIProperties.modalBottomSheetsEdges),
                          topRight: Radius.circular(
                              CommonUIProperties.modalBottomSheetsEdges),
                        ),
                      ),
                      context: context,
                      builder: (context) => EditTicketBottomSheet(
                        agendaCardNumber:
                            widget.meetingAgnedaCard.agendaCardOrder ?? -1,
                        chapterMeetingId: widget.chapterMeetingId,
                        agendaCardRoleName:
                            widget.meetingAgnedaCard.roleName ?? "",
                        agendaCardRoleOrderPlace:
                            widget.meetingAgnedaCard.roleOrderPlace ?? -1,
                        agendaCardTitle:
                            widget.meetingAgnedaCard.agendaTitle ?? "",
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.meetingAgnedaCard.agendaTitle!.isEmpty
                                ? " "
                                : widget.meetingAgnedaCard.agendaTitle ??
                                    "Title",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(AppMainColors.p70),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${widget.meetingAgnedaCard.roleName ?? 'Role'} ${widget.meetingAgnedaCard.roleOrderPlace ?? '1'}"
                            " By , ${widget.meetingAgnedaCard.allocatedRolePlayerDetails?.rolePlayerName ?? 'Name'}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Color(AppMainColors.p50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
