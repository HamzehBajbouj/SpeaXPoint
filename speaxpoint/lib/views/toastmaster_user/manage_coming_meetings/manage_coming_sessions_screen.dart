import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:speaxpoint/models/chapter_meeting.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_coming_sessions_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_coming_meetings/bottomSheet.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_coming_meetings/create_new_session_dialog.dart';
import 'package:provider/provider.dart';

class ManageComingSessionsScreen extends StatefulWidget {
  const ManageComingSessionsScreen({super.key});

  @override
  State<ManageComingSessionsScreen> createState() =>
      _ManageComingSessionsScreenState();
}

class _ManageComingSessionsScreenState
    extends State<ManageComingSessionsScreen> {
  late ManageComingSessionsViewModel _manageComingSessionsViewModel;

  @override
  void initState() {
    super.initState();
    _manageComingSessionsViewModel =
        Provider.of<ManageComingSessionsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(AppMainColors.p70),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Manage Coming Sessions",
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p70),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        fit: BoxFit.fill,
                        "assets/images/ideas_flow.svg",
                        allowDrawingOutsideViewBox: false,
                        width: 150,
                        height: 180,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Manage Coming Sessions",
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(AppMainColors.p90),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Manage your club incoming chapter meetings sessions preparations, create meeting agenda, allocate role players and create new sessions.All in one place.",
                                maxLines: 7,
                                style: TextStyle(
                                  height: 1.4,
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p50),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            outlinedButton(
                                callBack: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CreateNewSessionDialog();
                                    },
                                  );
                                },
                                content: "Create A New Session",
                                fontSize: 12,
                                buttonHeight: 30,
                                buttonWidth: 180),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "My Club Sessions",
                style: TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(AppMainColors.p90),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<List<ChapterMeeting>>(
                  stream:
                      _manageComingSessionsViewModel.getChapterMeetingsList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final List<ChapterMeeting> items = snapshot.data!;
                      if (items.isEmpty) {
                        return const Center(
                          child: Text(
                            "You have not created any Chapter Meeting Sessions yet!",
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Color(AppMainColors.p50),
                            ),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, index) => const SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.all(0),
                              elevation: 0,
                              color: _getCardColor(
                                  items[index].chapterMeetingStatus!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    CommonUIProperties.cardRoundedEdges),
                              ),
                              child: ListTile(
                                  onTap: () {
                                    showMaterialModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              CommonUIProperties
                                                  .modalBottomSheetsEdges),
                                          topRight: Radius.circular(
                                              CommonUIProperties
                                                  .modalBottomSheetsEdges),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          ComingSessionOptionBottomSheet(
                                        title: items[index].chapterTitle!,
                                        date: DateTime.parse(
                                            items[index].dateOfMeeting!),
                                      ),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  title: Text(
                                    items[index].chapterTitle!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Color(AppMainColors.p80),
                                    ),
                                  ),
                                  subtitle: Text(
                                    DateFormat("h:mm a, EEEE, MMM d, yyyy")
                                        .format(DateTime.parse(
                                            items[index].dateOfMeeting!)),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p50),
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _getCardTrailingIcon(
                                            items[index].chapterMeetingStatus!),
                                        color: _getCardIconColor(
                                            items[index].chapterMeetingStatus!),
                                        size: 29,
                                      ),
                                      Text(
                                        items[index].chapterMeetingStatus!,
                                        style: TextStyle(
                                          fontFamily:
                                              CommonUIProperties.fontType,
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          color: _getCardIconColor(items[index]
                                              .chapterMeetingStatus!),
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCardColor(String sessionStatus) {
    switch (sessionStatus) {
      case "Completed":
        return const Color(AppMainColors.completedSessionCard);
      case "Pending":
        return const Color(AppMainColors.pendingSessionCard);
      case "Coming":
        return const Color(AppMainColors.comingSessionCard);
      default:
        return Colors.grey;
    }
  }

  Color _getCardIconColor(String sessionStatus) {
    switch (sessionStatus) {
      case "Completed":
        return const Color(AppMainColors.completedSessionCardIcon);
      case "Pending":
        return const Color(AppMainColors.pendingSessionCardIcon);
      case "Coming":
        return const Color(AppMainColors.comingSessionCardIcon);
      default:
        return Colors.redAccent;
    }
  }

  IconData _getCardTrailingIcon(String sessionStatus) {
    switch (sessionStatus) {
      case "Completed":
        return Icons.check_circle_outline;
      case "Pending":
        return Icons.pending_outlined;
      case "Coming":
        return Icons.schedule_outlined;
      default:
        return Icons.error_outline;
    }
  }
}



// Card(
//                 margin: const EdgeInsets.all(0),
//                 elevation: 0,
//                 color: _getCardColor("Completed"),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                       CommonUIProperties.cardRoundedEdges),
//                 ),
//                 child: ListTile(
//                     onTap: () {
//                       showMaterialModalBottomSheet(
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(
//                                 CommonUIProperties.modalBottomSheetsEdges),
//                             topRight: Radius.circular(
//                                 CommonUIProperties.modalBottomSheetsEdges),
//                           ),
//                         ),
//                         context: context,
//                         builder: (context) => ComingSessionOptionBottomSheet(
//                           title: "Chapter Meeting 15",
//                           date: DateTime.now(),
//                         ),
//                       );
//                     },
//                     contentPadding: const EdgeInsets.only(
//                       left: 20,
//                       right: 20,
//                     ),
//                     title: const Text(
//                       "Chapter Meeting 15 ",
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontFamily: CommonUIProperties.fontType,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500,
//                         color: Color(AppMainColors.p80),
//                       ),
//                     ),
//                     subtitle: Text(
//                       DateFormat("h:mm a, EEEE, MMM d, yyyy")
//                           .format(DateTime.now()),
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontFamily: CommonUIProperties.fontType,
//                         fontSize: 13,
//                         fontWeight: FontWeight.normal,
//                         color: Color(AppMainColors.p50),
//                       ),
//                     ),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           _getCardTrailingIcon("Completed"),
//                           color: _getCardIconColor("Completed"),
//                           size: 29,
//                         ),
//                         Text(
//                           "Completed",
//                           style: TextStyle(
//                             fontFamily: CommonUIProperties.fontType,
//                             fontSize: 11,
//                             fontWeight: FontWeight.normal,
//                             color: _getCardIconColor("Completed"),
//                           ),
//                         )
//                       ],
//                     )),
//               );