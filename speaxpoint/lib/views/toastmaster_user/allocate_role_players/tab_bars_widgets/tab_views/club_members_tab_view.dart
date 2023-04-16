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
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/options_selections.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/tab_bars_widgets/allocated_role_player_lists.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/add_club_member_role_player_bottom_sheet.dart';

class ClubMembersTabView extends StatefulWidget {
  const ClubMembersTabView({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });
  final String chapterMeetingId;
  final String clubId;

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
          AllocatedRolePlayersLists(
            allocatedRolePlayerType: AllocatedRolePlayerType.ClubMember.name,
            chapterMeetingId: widget.chapterMeetingId,
          ),
        ],
      ),
    );
  }
}
