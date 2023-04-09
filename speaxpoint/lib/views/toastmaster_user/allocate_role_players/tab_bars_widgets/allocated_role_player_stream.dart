import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';

class AllocatedRolePlayersStream extends StatefulWidget {
  const AllocatedRolePlayersStream(
      {super.key,
      required this.allocatedRolePlayerType,
      required this.chapterMeetingId});

  final String allocatedRolePlayerType;
  final String chapterMeetingId;

  @override
  State<AllocatedRolePlayersStream> createState() =>
      _AllocatedRolePlayersStreamState();
}

class _AllocatedRolePlayersStreamState
    extends State<AllocatedRolePlayersStream> {
  late AllocateRolePlayersViewModel _allocateRolePlayersVM;
  @override
  void initState() {
    super.initState();
    _allocateRolePlayersVM =
        Provider.of<AllocateRolePlayersViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<AllocatedRolePlayer>>(
        stream: _allocateRolePlayersVM.getAllocatedRolePlayers(
          widget.chapterMeetingId,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final List<AllocatedRolePlayer> items = snapshot.data!
                .where((element) =>
                    element.allocatedRolePlayerType ==
                    widget.allocatedRolePlayerType)
                .toList();
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  "You have not allocated any roles yet!",
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
                  if (widget.allocatedRolePlayerType ==
                          AllocatedRolePlayerType.ClubMember.name ||
                      widget.allocatedRolePlayerType ==
                          AllocatedRolePlayerType.OtherClubMember.name) {
                    return allocatedRoleCard(
                        deleteAction: () async {
                          await _allocateRolePlayersVM.deleteRolePlayerCard(
                              widget.chapterMeetingId,
                              items[index].allocatedRolePlayerUniqueId ?? -1);
                        },
                        playerName: items[index].rolePlayerName ?? " ",
                        role: items[index].roleName ?? " ",
                        rolePlace: items[index].roleName == LisrOfRolesPlayers.Speaker.name ||
                                items[index].roleName == LisrOfRolesPlayers.Speach_Evaluator.name.replaceAll("_", " ")
                            ? items[index].roleOrderPlace
                            : null);
                  } else {
                    return allocatedGuestRoleCard(
                        guestInvitationCode: items[index].guestInvitationCode ?? " ",
                        deleteAction: () async {
                          await _allocateRolePlayersVM.deleteRolePlayerCard(
                              widget.chapterMeetingId,
                              items[index].allocatedRolePlayerUniqueId ?? -1);
                        },
                        playerName: items[index].rolePlayerName ?? " ",
                        role: items[index].roleName ?? " ",
                        rolePlace: items[index].roleName == LisrOfRolesPlayers.Speaker.name||
                                items[index].roleName == LisrOfRolesPlayers.Speach_Evaluator.name.replaceAll("_", " ")
                            ? items[index].roleOrderPlace
                            : null);
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}
