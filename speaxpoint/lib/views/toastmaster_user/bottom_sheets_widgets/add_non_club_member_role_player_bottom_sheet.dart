import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/select_role_bottom_sheet.dart';

class AddNonClubMemberRolePlayerBottomSheet extends StatelessWidget {
  AddNonClubMemberRolePlayerBottomSheet({
    super.key,
    required this.bottomSheetTitle,
    required this.inputFieldHintText,
    required this.confirmAcation,
  });

  final String bottomSheetTitle;
  final String inputFieldHintText;
  final Future<void> Function(String, String, int) confirmAcation;

  final TextEditingController _firstInputFieldController =
      TextEditingController();
  final TextEditingController _rolePlayerEditingController =
      TextEditingController();
  String _roleName = " ";
  int _roleOrderPlace = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
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
                  Text(
                    bottomSheetTitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Color(AppMainColors.p80),
                    ),
                  ),
                  textButton(
                    callBack: () async {
                      if (_formKey.currentState!.validate()) {
                        await confirmAcation(
                          _firstInputFieldController.text,
                          _roleName,
                          _roleOrderPlace,
                        );
                      }
                    },
                    content: const Text(
                      "Confirm",
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
              Consumer<AllocateRolePlayersViewModel>(
                builder: (_, value, child) {
                  return Visibility(
                    visible: !value.toastmasterUsernameIsfound,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Error !',
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.warningError75),
                          ),
                        ),
                        Text(
                          "It seems there is no a toastmaster with a username : ${_firstInputFieldController.text}",
                          style: const TextStyle(
                            height: 1.4,
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.p70),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              outlineTextField(
                  hintText: inputFieldHintText,
                  keyboardType: TextInputType.text,
                  onChangeCallBack: (data) {},
                  isRequired: true,
                  controller: _firstInputFieldController),
              const SizedBox(height: 20),
              outlineTextFieldWithTrailingIcon(
                readOnly: true,
                controller: _rolePlayerEditingController,
                hintText: "Select Role Player",
                isRequired: true,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
