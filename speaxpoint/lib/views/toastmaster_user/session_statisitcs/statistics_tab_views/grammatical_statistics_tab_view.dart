import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/grammarian_note.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/statisitcs/session_statistics_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/bottom_sheets_widgets/view_note_details_bottom_sheet.dart';

class GrammaticalStatisticsTabView extends StatefulWidget {
  const GrammaticalStatisticsTabView({
    super.key,
    required this.chapterMeetingId,
    required this.toastmasterId,
  });
  final String chapterMeetingId;
  final String toastmasterId;
  @override
  State<GrammaticalStatisticsTabView> createState() =>
      _GrammaticalStatisticsTabViewState();
}

class _GrammaticalStatisticsTabViewState
    extends State<GrammaticalStatisticsTabView> {
  late SessionStatisticsViewModel _sessionStatisticsViewModel;
  @override
  void initState() {
    super.initState();
    _sessionStatisticsViewModel =
        Provider.of<SessionStatisticsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _sessionStatisticsViewModel.getAllGrammaticalNotes(
          chapterMeetingId: widget.chapterMeetingId,
          toastmasterId: widget.toastmasterId),
      builder: (
        context,
        AsyncSnapshot<List<GrammarianNote>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(AppMainColors.p40),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<GrammarianNote> grammaticalNotes = snapshot.data!;

            List<GrammarianNote> listWOTD = grammaticalNotes
                .where((obj) =>
                    obj.typeOfGrammarianNote == GrammarianNoteType.WOTD.name)
                .toList();
            List<GrammarianNote> listGrammaticalNote = grammaticalNotes
                .where((obj) =>
                    obj.typeOfGrammarianNote ==
                    GrammarianNoteType.GrammaticalNote.name)
                .toList();

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      fit: BoxFit.fill,
                      "assets/images/things_to_say.svg",
                      allowDrawingOutsideViewBox: false,
                      // width: 200,
                      height: 170,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Grammars Summary",
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
                  Text(
                    "You have used the WOTD ${listWOTD.length} times,"
                    " and a total of ${listGrammaticalNote.length} grammatical notes were taken.",
                    style: const TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p70),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (listGrammaticalNote.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemCount: listGrammaticalNote.length,
                        separatorBuilder: (_, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return evaluationNoteCard(
                              iconButtonAction: () async {
                                showMaterialModalBottomSheet(
                                  enableDrag: false,
                                  backgroundColor: const Color(
                                      AppMainColors.backgroundAndContent),
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
                                      ViewNoteDetailsBottomSheet(
                                    noteContent:
                                        listGrammaticalNote[index].noteContent!,
                                    noteTitle:
                                        listGrammaticalNote[index].noteTitle!,
                                  ),
                                );
                              },
                              noteContent:
                                  listGrammaticalNote[index].noteContent!,
                              noteTitle: listGrammaticalNote[index].noteTitle);
                        },
                      ),
                    ),
                ],
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Text(
            'State: ${snapshot.connectionState}',
            style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.warningError75),
            ),
          );
        }
      },
    );
  }
}
