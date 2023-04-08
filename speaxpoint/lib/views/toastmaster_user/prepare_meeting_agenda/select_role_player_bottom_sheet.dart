import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class SelectRolePlayerBottomSheet extends StatefulWidget {
  const SelectRolePlayerBottomSheet({super.key});

  @override
  State<SelectRolePlayerBottomSheet> createState() =>
      _SelectRolePlayerBottomSheetState();
}

class _SelectRolePlayerBottomSheetState
    extends State<SelectRolePlayerBottomSheet> {
  List<String> listOfRole = LisrOfRolesPlayers.values
      .map((e) => e.name.replaceAll('_', ' '))
      .toList();
  bool _showRoleNumber = true;
  //these are the initiail data which will be updated whenever the scrollers are change
  String _roleName = LisrOfRolesPlayers.Speaker.name;
  int _rolePlace = 1;

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
                  "Select The Role",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p80),
                  ),
                ),
                textButton(
                  callBack: () {
                    Navigator.pop(
                      context,
                      {
                        'roleName': _roleName,
                        'roleOrderPlace': _rolePlace,
                      },
                    );
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
            const SizedBox(height: 25),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Agende Role",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 120,
                        height: 150,
                        child: ListWheelScrollView.useDelegate(
                          onSelectedItemChanged: (value) {
                            String currentSelectRole = listOfRole[value];
                            if (currentSelectRole == "Speaker" ||
                                currentSelectRole ==
                                    LisrOfRolesPlayers.Speach_Evaluator.name
                                        .replaceAll("_", " ")) {
                              setState(() {
                                _showRoleNumber = true;
                                _roleName = listOfRole[value];
                              });
                            } else {
                              setState(() {
                                _showRoleNumber = false;
                                _roleName = listOfRole[value];
                                //this part is importantlly need, because when the rolePlace
                                //is hidden it will keep the previous value which leads to allow
                                //having Ah counter 1 , Ah counter 2 , so it's important to update it
                                _rolePlace = 1;
                              });
                            }
                          },
                          itemExtent: 50,
                          perspective: 0.005,
                          diameterRatio: 1.2,
                          physics: const FixedExtentScrollPhysics(),
                          controller:
                              FixedExtentScrollController(initialItem: 0),
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: listOfRole.length,
                            builder: (context, index) {
                              return FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  listOfRole[index],
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Color(AppMainColors.p60),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _showRoleNumber,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Role Place",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 70,
                          height: 150,
                          child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              setState(() {
                                _rolePlace = value + 1;
                              });
                            },
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: listOfRole.length,
                              builder: (context, index) {
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p60),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
