import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';

class UpdateExitingRolePlayerDialog extends StatefulWidget {
  UpdateExitingRolePlayerDialog({
    super.key,
    required this.chapterMeetingId,
    required this.roleName,
    required this.rolePlace,
    required this.selectedToastmaster,
  });

  final String chapterMeetingId;
  final String roleName;
  final int rolePlace;
  final Toastmaster selectedToastmaster;

  @override
  State<UpdateExitingRolePlayerDialog> createState() =>
      _UpdateExitingRolePlayerDialogState();
}

class _UpdateExitingRolePlayerDialogState
    extends State<UpdateExitingRolePlayerDialog> {
  late AllocateRolePlayersViewModel _allocateRolePlayersVM;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _allocateRolePlayersVM =
        Provider.of<AllocateRolePlayersViewModel>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Warning !',
        style: TextStyle(
          fontFamily: CommonUIProperties.fontType,
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Color(AppMainColors.warningError75),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "It seems this Role is already taken by another player, Do you want to update role player details ?",
            style: TextStyle(
              height: 1.4,
              fontFamily: CommonUIProperties.fontType,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p70),
            ),
          ),
          Consumer<AllocateRolePlayersViewModel>(
            builder: (_, value, child) {
              return Text(
                value.updateRoleStatus?.whenError(
                      (error) {
                        return error.message;
                      },
                    ) ??
                    " ",
                style: const TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(AppMainColors.warningError75),
                ),
              );
            },
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        textButton(
          callBack: () {
            Navigator.of(context).pop();
          },
          content: const Text(
            "Cancel",
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p50),
            ),
          ),
        ),
        filledTextButton(
            callBack: () async {
              await _allocateRolePlayersVM
                  .updateExitngRoleDetails(
                      widget.chapterMeetingId,
                      widget.roleName,
                      widget.rolePlace,
                      widget.selectedToastmaster)
                  .then((_) {
                _allocateRolePlayersVM.updateRoleStatus?.whenSuccess(
                  (success) {
                    Navigator.of(context).pop();
                  },
                );
              });
            },
            content: 'Update',
            buttonHeight: 40,
            buttonWidth: 90),
      ],
    );
  }
}
