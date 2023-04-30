import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class VolunteerToRoleSlotCompletionMessageDialog extends StatelessWidget {
  const VolunteerToRoleSlotCompletionMessageDialog(
      {super.key, required this.message, required this.isWarningMessage});
  final String message;
  final bool isWarningMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isWarningMessage ? 'Warning !' : 'Success !',
        style: TextStyle(
          fontFamily: CommonUIProperties.fontType,
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Color(isWarningMessage
              ? AppMainColors.warningError75
              : AppMainColors.p80),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
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
      actions: [
        textButton(
          callBack: () {
            Navigator.of(context).pop();
          },
          content: const Text(
            "Close",
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p50),
            ),
          ),
        ),
      ],
    );
  }
}
