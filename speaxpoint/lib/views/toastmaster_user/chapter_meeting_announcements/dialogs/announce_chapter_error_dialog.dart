import 'package:flutter/material.dart';

import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class AnnounceChapterErrorDialog extends StatelessWidget {
  const AnnounceChapterErrorDialog({super.key});

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
            "You can not create new chapter meeting announcement as you have an existing one,"
            "to create a new one, please delete the old announcement",
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
