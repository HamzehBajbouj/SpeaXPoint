import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/select_role_bottom_sheet.dart';

class EditAgendaCardBottomSheet extends StatefulWidget {
  const EditAgendaCardBottomSheet({
    super.key,
    required this.chapterMeetingId,
    required this.agendaCardNumber,
    required this.agendaCardTitle,
    required this.agendaCardRoleName,
    required this.agendaCardRoleOrderPlace,
  });
  final String chapterMeetingId;
  final String agendaCardTitle;
  final String agendaCardRoleName;
  final int agendaCardNumber;
  final int agendaCardRoleOrderPlace;

  @override
  State<EditAgendaCardBottomSheet> createState() =>
      _EditTicketBottomSheetState();
}

class _EditTicketBottomSheetState extends State<EditAgendaCardBottomSheet> {
  late PrepareMeetingAgendaViewModel _prepareMeetingAgendaViewModel;

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _rolePlayerEditingController =
      TextEditingController();
  String _roleName = " ";
  int _roleOrderPlace = 1;

  @override
  void initState() {
    super.initState();
    _prepareMeetingAgendaViewModel =
        Provider.of<PrepareMeetingAgendaViewModel>(context, listen: false);
    _titleEditingController.text =
        widget.agendaCardTitle.isEmpty ? "" : widget.agendaCardTitle;

    if (widget.agendaCardRoleOrderPlace > 0 &&
        widget.agendaCardRoleName.isNotEmpty) {
      _rolePlayerEditingController.text =
          "${widget.agendaCardRoleName} ${widget.agendaCardRoleOrderPlace}";
    } else {
      _rolePlayerEditingController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Agenda Details",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p80),
                  ),
                ),
                textButton(
                  callBack: () async {
                    if (_titleEditingController.text.isEmpty) {
                      _titleEditingController.text = " ";
                    }
                    await _prepareMeetingAgendaViewModel
                        .updateAgendaCardDetails(
                            chapterMeetingId: widget.chapterMeetingId,
                            agendaCardNumber: widget.agendaCardNumber,
                            agendaCardTitle: _titleEditingController.text,
                            roleName: _roleName,
                            roleOrderPlace: _roleOrderPlace)
                        .then(
                      (_) {
                        Navigator.pop(context);
                      },
                    );
                  },
                  content: const Text(
                    "Update Now",
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            outlineTextField(
                hintText: "Enter The Title",
                keyboardType: TextInputType.text,
                onChangeCallBack: (data) {},
                isRequired: false,
                controller: _titleEditingController),
            const SizedBox(height: 20),
            outlineTextFieldWithTrailingIcon(
              readOnly: true,
              controller: _rolePlayerEditingController,
              hintText: "Select Role",
              onChangeCallBack: (_) {},
              onTapCallBack: () {
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
                  builder: (context) => const SelectRoleBottomSheet(),
                ).then(
                  (value) {
                    if (value != null) {
                      String temp = " ";
                      //to hide the role order place if the role is not speaker or speach evaluator
                      if (value['roleName'] ==
                              LisrOfRolesPlayers.Speaker.name ||
                          value['roleName'] ==
                              LisrOfRolesPlayers.Speach_Evaluator.name
                                  .replaceAll("_", " ")) {
                        temp =
                            "${value['roleName']} ${value['roleOrderPlace']}";
                      } else {
                        temp = value['roleName'];
                      }
                      _rolePlayerEditingController.text = temp;
                      _roleName = value['roleName'];
                      _roleOrderPlace = value['roleOrderPlace'];
                    }
                  },
                );
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30,
                color: Color(AppMainColors.p20),
              ),
              isRequired: false,
            ),
            const SizedBox(height: 20),
            outlinedButton(
              callBack: () async {
                await _prepareMeetingAgendaViewModel
                    .deleteAgendaCard(
                        widget.chapterMeetingId, widget.agendaCardNumber)
                    .then(
                      (_) => _prepareMeetingAgendaViewModel
                          .deteteAgendaCardCardStatus
                          ?.whenSuccess(
                        (success) => Navigator.of(context).pop(),
                      ),
                    );
              },
              content: "Delete Agenda Card",
              buttonColor: const Color(AppMainColors.warningError50),
            ),
          ],
        ),
      ),
    );
  }
}
