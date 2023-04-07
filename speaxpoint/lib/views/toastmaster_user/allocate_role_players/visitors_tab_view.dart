import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/add_club_member_role_player_bottom_sheet.dart';

class VisitorsTabView extends StatefulWidget {
  const VisitorsTabView({super.key});

  @override
  State<VisitorsTabView> createState() => _VisitorsTabViewState();
}

class _VisitorsTabViewState extends State<VisitorsTabView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: filledTextButton(
                  callBack: () {
                    // showMaterialModalBottomSheet(
                    //   enableDrag: false,
                    //   backgroundColor:
                    //       const Color(AppMainColors.backgroundAndContent),
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(
                    //           CommonUIProperties.modalBottomSheetsEdges),
                    //       topRight: Radius.circular(
                    //           CommonUIProperties.modalBottomSheetsEdges),
                    //     ),
                    //   ),
                    //   context: context,
                    //   builder: (context) =>
                    //       const AddClubMemberRolePlayerBottomSheet(),
                    // );
                  },
                  content: "Add Visitor Player",
                  contentColor: Color(AppMainColors.p70),
                  backgroundColor: Color(AppMainColors.p10),
                  borderColor: Color(AppMainColors.p10),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            constraints: const BoxConstraints(
              minHeight: 30,
              maxHeight: 40,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(AppMainColors.p30),
                width: 1.3,
              ),
              borderRadius:
                  BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(maxWidth: 90),
                  child: const Center(
                    child: Text(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      "Speaker",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p30),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: 1,
                  color: const Color(AppMainColors.p30),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "dssd",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Color(AppMainColors.p30),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Color(AppMainColors.p30),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
