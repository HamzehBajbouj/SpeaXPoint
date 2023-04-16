import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/tab_bars_widgets/allocated_role_player_lists.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/update_existing_role_player_dialog.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/add_non_club_member_role_player_bottom_sheet.dart';

class GuestsTabView extends StatefulWidget {
  const GuestsTabView(
      {super.key, required this.chapterMeetingId, required this.clubId});
  final String chapterMeetingId;
  final String clubId;
  @override
  State<GuestsTabView> createState() => _VisitorsTabViewState();
}

class _VisitorsTabViewState extends State<GuestsTabView> {
  late AllocateRolePlayersViewModel _allocateRolePlayersVM;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allocateRolePlayersVM =
        Provider.of<AllocateRolePlayersViewModel>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: filledTextButton(
                  content: "Add New Guest",
                  contentColor: const Color(AppMainColors.p70),
                  backgroundColor: const Color(AppMainColors.p10),
                  borderColor: const Color(AppMainColors.p10),
                  callBack: () {
                    showMaterialModalBottomSheet(
                      enableDrag: false,
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
                      builder: (context) =>
                          AddNonClubMemberRolePlayerBottomSheet(
                        bottomSheetTitle: "Add Guest Role Player",
                        inputFieldHintText: "Guest Name",
                        confirmAcation:
                            (guestName, roleName, roleOrderPlace) async {
                          await _allocateRolePlayersVM
                              .validateRoleAvailability(widget.chapterMeetingId,
                                  roleName, roleOrderPlace)
                              .then(
                            (value) {
                              value.whenSuccess(
                                (success) async {
                                  if (success) {
                                    //when succes is true it mean that there is no existing role player
                                    //with the same role and place order
                                    await _allocateRolePlayersVM
                                        .allocateGuestRolePlayer(
                                      allocatedRolePlayerType:
                                          AllocatedRolePlayerType.Guest.name,
                                      chapterMeetingId: widget.chapterMeetingId,
                                      guestName: guestName,
                                      memberRolePlace: roleOrderPlace,
                                      roleName: roleName,
                                    )
                                        .then(
                                      (value) {
                                        value.whenSuccess(
                                          (_) {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    //display dialog when the role is occupid by another toastmaster
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return UpdateExitingRolePlayerDialog(
                                          guestName: guestName,
                                          chapterMeetingId:
                                              widget.chapterMeetingId,
                                          roleName: roleName,
                                          rolePlace: roleOrderPlace,
                                          selectedToastmaster: null,
                                          allocatedRolePlayerType:
                                              AllocatedRolePlayerType
                                                  .Guest.name,
                                        );
                                      },
                                    ).then(
                                      (_) {
                                        Navigator.pop(context);
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          AllocatedRolePlayersLists(
            allocatedRolePlayerType: AllocatedRolePlayerType.Guest.name,
            chapterMeetingId: widget.chapterMeetingId,
          ),
        ],
      ),
    );
  }
}
