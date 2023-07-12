import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/volunteer_announcement_view_details_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/dialogs/volunteer_to_role_slot_completion_message.dialog.dart';
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/dialogs/volunter_to_role_slot_confirmation_dialog.dart';

class VolunteerAnnouncementViewDetailsScreen extends StatefulWidget {
  const VolunteerAnnouncementViewDetailsScreen(
      {super.key, required this.chapterMeetingId, required this.clubId});
  final String chapterMeetingId;
  final String clubId;
  @override
  State<VolunteerAnnouncementViewDetailsScreen> createState() =>
      _VolunteerAnnouncementViewScreenState();
}

class _VolunteerAnnouncementViewScreenState
    extends State<VolunteerAnnouncementViewDetailsScreen> {
  late VolunteerAnnouncementViewDetailsViewModel
      _volunteerAnnouncementViewDetailsViewModel;

  @override
  void initState() {
    super.initState();
    _volunteerAnnouncementViewDetailsViewModel =
        Provider.of<VolunteerAnnouncementViewDetailsViewModel>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _volunteerAnnouncementViewDetailsViewModel
          .loadVolunteerAnnouncementDetails(
              chpaterMeetingId: widget.chapterMeetingId),
      builder: (
        context,
        AsyncSnapshot<void> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(AppMainColors.p40),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Color(AppMainColors.p70),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Volunteers Announcement Query",
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            CommonUIProperties.buttonRoundedEdges),
                        color: const Color(
                            AppMainColors.announcementDetailsCardBackground),
                        border: Border.all(
                          color: const Color(AppMainColors.p40),
                          width: 1.3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _volunteerAnnouncementViewDetailsViewModel
                                          .announcement.annoucementTitle ??
                                      "No Title Is Provided!",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(AppMainColors.p80),
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _volunteerAnnouncementViewDetailsViewModel
                                          .announcement
                                          .annoucementDescription ??
                                      "No Description Is Provided!",
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Color(AppMainColors.p50),
                                  ),
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Available Roles Slots",
                                  style: TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p80),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Consumer<
                                    VolunteerAnnouncementViewDetailsViewModel>(
                                  builder: (_, viewModel, child) {
                                    if (viewModel.volunteersSlots.isEmpty) {
                                      return const SizedBox(
                                        height: 200,
                                        child: Center(
                                          child: Text(
                                            "It seems there are no roles available for volunteering",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  CommonUIProperties.fontType,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Color(AppMainColors.p50),
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        height: 200,
                                        child: ListView.separated(
                                          itemCount:
                                              viewModel.volunteersSlots.length,
                                          separatorBuilder: (_, index) =>
                                              const SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return volunteerViewDetailsSlotCard(
                                              roleName: viewModel
                                                  .volunteersSlots[index]
                                                  .roleName!,
                                              rolePlace: viewModel
                                                  .volunteersSlots[index]
                                                  .roleOrderPlace!,
                                              onTapCallBack: () async {
                                                _volunteerAnnouncementViewDetailsViewModel
                                                    .validateApplicantExisting(
                                                  slotUnqiueId: viewModel
                                                      .volunteersSlots[index]
                                                      .slotUnqiueId!,
                                                  chapterMeetingId:
                                                      widget.chapterMeetingId,
                                                )
                                                    .then(
                                                  (value) {
                                                    value.whenSuccess(
                                                      (bool result) {
                                                        //if result is true , then it mean the user had applied to
                                                        //this slot before.
                                                        if (result) {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return const VolunteerToRoleSlotCompletionMessageDialog(
                                                                isWarningMessage:
                                                                    true,
                                                                message:
                                                                    "It Seems that you have applied to this role before."
                                                                    " The moment your application is accepted, it will be added to your meetings schedule",
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          //then since it's false , the user has not applied to here before
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return VolunteerToRoleSlotConfirmationDialog(
                                                                chapterMeetingId:
                                                                    widget
                                                                        .chapterMeetingId,
                                                                slotUnqiueId: viewModel
                                                                    .volunteersSlots[
                                                                        index]
                                                                    .slotUnqiueId!,
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                filledTextButton(
                                  buttonHeight: 40,
                                  callBack: () {
                                    context.pushRoute(
                                      ClubProfileAnnouncementViewRouter(
                                        forViewOnly: true,
                                        fromAnnouncementPage: true,
                                        clubId: widget.clubId,
                                      ),
                                    );
                                  },
                                  content: "View Club Profile",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
