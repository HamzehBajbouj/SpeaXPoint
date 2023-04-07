import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';

class SelectRolePlayerBottomSheet extends StatefulWidget {
  const SelectRolePlayerBottomSheet({super.key});

  @override
  State<SelectRolePlayerBottomSheet> createState() =>
      _SelectRolePlayerBottomSheetState();
}

class _SelectRolePlayerBottomSheetState
    extends State<SelectRolePlayerBottomSheet> {
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
            const Text(
              "Edit The Ticket",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p80),
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Container(
                width: 70,
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  onSelectedItemChanged: (value) => {},
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 13,
                    builder: (context, index) {
                      return Text(index.toString());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
