import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/tab_bars_widgets/allocated_role_player_lists.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/manage_volunteer_slot_bottom_sheet.dart';

class VolunteersTabView extends StatefulWidget {
  const VolunteersTabView(
      {super.key, required this.chapterMeetingId, required this.clubId});
  final String chapterMeetingId;
  final String clubId;
  @override
  State<VolunteersTabView> createState() => _VolunteersTabViewState();
}

class _VolunteersTabViewState extends State<VolunteersTabView> {
  late AllocateRolePlayersViewModel _allocateRolePlayersVM;
  @override
  void initState() {
    super.initState();
    _allocateRolePlayersVM =
        Provider.of<AllocateRolePlayersViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<List<VolunteerSlot>>(
              stream: _allocateRolePlayersVM.getVolunteersSlots(
                widget.chapterMeetingId,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(AppMainColors.p40),
                    ),
                  );
                } else {
                  final List<VolunteerSlot> items = snapshot.data!;

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
                        return volunteerSlotCard(
                            deleteAction: () async {
                              await _allocateRolePlayersVM.deleteVolunteerSlot(
                                  chapterMeetingId: widget.chapterMeetingId,
                                  slotUnqiueId: items[index].slotUnqiueId!,
                                  roleName: items[index].roleName!,
                                  roleOrderPlace: items[index].roleOrderPlace!);
                            },
                            onCardTap: () {
                              showMaterialModalBottomSheet(
                                enableDrag: false,
                                backgroundColor: const Color(
                                    AppMainColors.backgroundAndContent),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(CommonUIProperties
                                        .modalBottomSheetsEdges),
                                    topRight: Radius.circular(CommonUIProperties
                                        .modalBottomSheetsEdges),
                                  ),
                                ),
                                context: context,
                                builder: (context) =>
                                    ManageVolunteerSlotBottomSheet(
                                  chapterMeetingId: widget.chapterMeetingId,
                                  slotDetails: items[index],
                                ),
                              );
                            },
                            role: items[index].roleName!,
                            rolePlace: items[index].roleOrderPlace,
                            slotStatus: items[index].slotStatus!,
                            cardColor: _getTheVolunteerSlotColor(
                                items[index].slotStatus!));
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getTheVolunteerSlotColor(String status) {
    if (status == VolunteerSlotStatus.AcceptedApplication.name) {
      return Color(AppMainColors.volunteerAcceptedApplicantStatus);
    } else if (status == VolunteerSlotStatus.PendingApplication.name) {
      return Color(AppMainColors.volunteerPendingApplicantStatus);
    } else {
      return Color(AppMainColors.volunteerNoApplicantStatus);
    }
  }
}
