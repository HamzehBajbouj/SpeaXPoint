import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

class ComingSessionOptionBottomSheet extends StatelessWidget {
  final String title;
  final DateTime date;

  const ComingSessionOptionBottomSheet(
      {super.key, required this.title, required this.date});

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
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p80),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(AppMainColors.p60),
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(date),
                      style: const TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p50),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Time",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(AppMainColors.p60),
                      ),
                    ),
                    Text(
                      DateFormat.jm().format(date),
                      style: const TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 110,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              CommonUIProperties.modalBottomSheetsEdges),
                          border: Border.all(
                            width: 1.3,
                            color: const Color(AppMainColors.p40),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.group_add_outlined,
                              color: Color(AppMainColors.p40),
                              size: 40,
                            ),
                            Expanded(
                              child: Text(
                                "Allocate\nRole Players",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p40),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(top: 8),
                        width: 110,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              CommonUIProperties.modalBottomSheetsEdges),
                          border: Border.all(
                            width: 1.3,
                            color: const Color(AppMainColors.p40),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.view_agenda_outlined,
                              color: Color(AppMainColors.p40),
                              size: 35,
                            ),
                            Expanded(
                              child: Text(
                                "Manage\nAgenda",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8),
                      width: 110,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            CommonUIProperties.modalBottomSheetsEdges),
                        border: Border.all(
                          width: 1.3,
                          color: const Color(AppMainColors.p40),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.campaign_outlined,
                            color: Color(AppMainColors.p40),
                            size: 40,
                          ),
                          Expanded(
                            child: Text(
                              "Announce\nMeeting",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color(AppMainColors.p40),
                              ),
                            ),
                          ),
                        ],
                      ),
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
