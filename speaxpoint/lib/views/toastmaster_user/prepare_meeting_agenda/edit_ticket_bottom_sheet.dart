import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/select_role_player_bottom_sheet.dart';

class EditTicketBottomSheet extends StatefulWidget {
  const EditTicketBottomSheet(
      {super.key,
      required this.chapterMeetingId,
      required this.agendaCardNumber});
  final String chapterMeetingId;
  final int agendaCardNumber;

  @override
  State<EditTicketBottomSheet> createState() => _EditTicketBottomSheetState();
}

class _EditTicketBottomSheetState extends State<EditTicketBottomSheet> {
  late PrepareMeetingAgendaViewModel _prepareMeetingAgendaViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _prepareMeetingAgendaViewModel =
        Provider.of<PrepareMeetingAgendaViewModel>(context);
  }

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _rolePlayerEditingController = TextEditingController();

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
                  callBack: () {},
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
              hintText: "Select Role Player",
              onChangeCallBack: (data) {},
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
                  builder: (context) => const SelectRolePlayerBottomSheet(),
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
