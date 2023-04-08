import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/allocated_role_player.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/options_selections.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/add_club_member_role_player_bottom_sheet.dart';

class ClubMembersTabView extends StatefulWidget {
  final String chapterMeetingId;
  final String clubId;
  const ClubMembersTabView({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  @override
  State<ClubMembersTabView> createState() => _ClubMembersTabViewState();
}

class _ClubMembersTabViewState extends State<ClubMembersTabView> {
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
          Row(
            children: [
              Expanded(
                child: filledTextButton(
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
                      builder: (context) => AddClubMemberRolePlayerBottomSheet(
                        chapterMeetingId: widget.chapterMeetingId,
                        clubId: widget.clubId,
                      ),
                    );
                  },
                  content: "Add Club Member Player",
                  contentColor: Color(AppMainColors.p70),
                  backgroundColor: Color(AppMainColors.p10),
                  borderColor: Color(AppMainColors.p10),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
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
                          AllocatedRolePlayerType.ClubMember.name)
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
                        return allocatedRoleCard(
                            cardId:
                                items[index].allocatedRolePlayerUniqueId ?? -1,
                            playerName: items[index].rolePlayerName ?? " ",
                            role: items[index].roleName ?? " ",
                            rolePlace: items[index].roleName == "Speaker" ||
                                    items[index].roleName == "Speach Evaluator"
                                ? items[index].roleOrderPlace
                                : null);
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

  Widget allocatedRoleCard({
    required String role,
    required int? rolePlace,
    required String playerName,
    required int cardId,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 30,
        maxHeight: 40,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(AppMainColors.p30),
          width: 1.3,
        ),
        borderRadius:
            BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 90),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  "${role} ${rolePlace ?? ""}",
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(AppMainColors.p30),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: const Color(AppMainColors.p30),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      playerName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p30),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _allocateRolePlayersVM.deleteRolePlayerCard(
                          widget.chapterMeetingId, cardId);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Color(AppMainColors.p30),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
