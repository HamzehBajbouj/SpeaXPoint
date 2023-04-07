import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';

class NoAgendaYetView extends StatefulWidget {
  const NoAgendaYetView({super.key, required this.chapterMeetingId});
  final String chapterMeetingId;
  @override
  State<NoAgendaYetView> createState() => _NoAgendaYetViewState();
}

class _NoAgendaYetViewState extends State<NoAgendaYetView> {
  late PrepareMeetingAgendaViewModel _prepareMeetingAgendaViewModel;
  final TextEditingController _divisionsNumberController =
      TextEditingController();
  bool _showErrorMessage = false;

  @override
  void initState() {
    super.initState();
    _prepareMeetingAgendaViewModel =
        Provider.of<PrepareMeetingAgendaViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            fit: BoxFit.fill,
            "assets/images/searching.svg",
            allowDrawingOutsideViewBox: false,
            width: 210,
            height: 190,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "No Available Agenda",
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p90),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            width: 260,
            child: Text(
              "There is no agenda has been created for this chapter meeting. Please enter the number of meeting’s topics divisions and click generate now button.",
              maxLines: 4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(AppMainColors.p50),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: Row(
              children: [
                Expanded(
                  child: outlineTextField(
                    isRequired: true,
                    hintText: "Divisions Number",
                    keyboardType: TextInputType.number,
                    controller: _divisionsNumberController,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                filledTextButton(
                    callBack: () async {
                      if (_divisionsNumberController.text.isEmpty) {
                        setState(() {
                          _showErrorMessage = true;
                        });
                      } else {
                        setState(() {
                          _showErrorMessage = false;
                        });
                        await _prepareMeetingAgendaViewModel
                            .generateListOfAgenda(
                          widget.chapterMeetingId,
                          int.parse(_divisionsNumberController.text),
                        );
                      }
                    },
                    content: 'Generate',
                    buttonHeight: 47,
                    buttonWidth: 90),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: _showErrorMessage,
            child: const Text(
              "Pleae enter the number of divisions ",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(AppMainColors.warningError75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
