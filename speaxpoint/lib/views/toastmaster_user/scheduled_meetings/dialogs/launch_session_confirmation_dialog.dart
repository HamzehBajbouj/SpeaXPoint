import 'dart:io';

import 'package:flutter/material.dart';

import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class LaunchSessionConfirmationDialog extends StatefulWidget {
  const LaunchSessionConfirmationDialog({
    super.key,
    required this.chapterMeetingId,
  });

  final String chapterMeetingId;

  @override
  State<LaunchSessionConfirmationDialog> createState() =>
      _LaunchSessionConfirmationDialogState();
}

class _LaunchSessionConfirmationDialogState
    extends State<LaunchSessionConfirmationDialog> {
  @override
  void initState() {
    super.initState();
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
        children: const [
          Text(
            "Are you sure you want to launch the chapter meeting session?.",
            style: TextStyle(
              height: 1.4,
              fontFamily: CommonUIProperties.fontType,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p70),
            ),
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
            callBack: () async {},
            content: 'Confirm',
            buttonHeight: 40,
            buttonWidth: 90),
      ],
    );
  }
}
