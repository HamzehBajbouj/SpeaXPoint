import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class ViewNoteDetailsBottomSheet extends StatelessWidget {
  const ViewNoteDetailsBottomSheet({
    super.key,
    required this.noteContent,
    this.noteTitle,
  });
  final String noteContent;
  final String? noteTitle;

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
                Text(
                  noteTitle == null || noteTitle!.isEmpty
                      ? "Note Content"
                      : noteTitle!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p90),
                  ),
                ),
                textButton(
                  callBack: () {
                    Navigator.pop(context);
                  },
                  content: const Text(
                    "Close",
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
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Text(
                    noteContent,
                    style: const TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
