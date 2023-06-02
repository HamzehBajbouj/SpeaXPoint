import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/tab_bars_widgets/allocate_role_players_tabbar.dart';

class AllocateRolePlayerScreen extends StatelessWidget {
  final String chapterMeetingId;
  final String clubId;
  const AllocateRolePlayerScreen({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    final allocateRolePlayersViewModel =
        context.read<AllocateRolePlayersViewModel>();
    //this method can be called in a future builder everytime we open this screen
    //so it checks , but we want to avoid the circuleWaiting icon
    allocateRolePlayersViewModel.validateAllocationOfAllRoles(chapterMeetingId);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(AppMainColors.p70),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Allocate Role Players",
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p70),
          ),
        ),
      ),
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Allocate Role Players",
                style: TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(AppMainColors.p90),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Allocate and manage the chapter meeting role players from your "
                "club, other clubs, guests or volunteers .",
                style: TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(AppMainColors.p50),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<AllocateRolePlayersViewModel>(
                builder: (_, viewModel, child) {
                  if (viewModel.agendaWithNoRolePlayersList.isEmpty) {
                    return Container();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: 'Warning ! ',
                            style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                color: Color(AppMainColors.warningError75),
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "it seems there are some Role that have not been "
                                    "allocated it, allocate them or click on :",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        textButton(
                          callBack: () {
                            context
                                .pushRoute(
                              AskForVolunteersRouter(
                                chapterMeetingId: chapterMeetingId,
                                viewMode: false,
                                clubId: clubId,
                              ),
                            )
                                .then(
                              (value) {
                                //check again after returning to this page,
                                //it's needed since this widget is a stateless one
                                allocateRolePlayersViewModel
                                    .validateAllocationOfAllRoles(
                                        chapterMeetingId);
                              },
                            );
                          },
                          content: const Text(
                            "Ask For Volunteers",
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(AppMainColors.p70),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: AllocateRolePlayersTabBar(
                  chapterMeetingId: chapterMeetingId,
                  clubId: clubId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
