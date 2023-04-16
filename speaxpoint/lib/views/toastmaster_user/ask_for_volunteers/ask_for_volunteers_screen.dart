import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/ask_for_volunteers_view_model.dart';

class AskForVolunteersScreen extends StatefulWidget {
  const AskForVolunteersScreen({super.key, required this.chapterMeetingId});

  final String chapterMeetingId;

  @override
  State<AskForVolunteersScreen> createState() => _AskForVolunteersScreenState();
}

class _AskForVolunteersScreenState extends State<AskForVolunteersScreen> {
  late AskForVolunteersViewModel _askForVolunteersViewModel;
  final _annoucementTitleController = TextEditingController();
  final _annoucementDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _askForVolunteersViewModel =
        Provider.of<AskForVolunteersViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _annoucementTitleController.dispose();
    _annoucementDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _askForVolunteersViewModel
          .initiateScreenElements(widget.chapterMeetingId),
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
          _annoucementTitleController.text =
              _askForVolunteersViewModel.announcementTitle;
          _annoucementDescriptionController.text =
              _askForVolunteersViewModel.announcementDescription;
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Color(AppMainColors.p70),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Ask For Volunteers",
                style: TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(AppMainColors.p70),
                ),
              ),
            ),
            backgroundColor: const Color(AppMainColors.backgroundAndContent),
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<AskForVolunteersViewModel>(
                          builder: (_, viewModel, child) {
                            if (viewModel.isTherePreviousAnnouncement) {
                              return RichText(
                                text: const TextSpan(
                                  text: 'Warning ! ',
                                  style: TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 15,
                                      color:
                                          Color(AppMainColors.warningError75),
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          "it seems you have an exiting announcement"
                                          "update the details to update the announcement.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Announcement Title",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        outlineTextField(
                          keyboardType: TextInputType.multiline,
                          controller: _annoucementTitleController,
                          hintText: "Enter The Announcement Title",
                          isRequired: true,
                          onChangeCallBack: (data) {
                            if (_annoucementTitleController.text.isEmpty ||
                                _annoucementDescriptionController
                                    .text.isEmpty) {
                              _askForVolunteersViewModel.enableButton(false);
                            } else {
                              {
                                _askForVolunteersViewModel.enableButton(true);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Announcement Description",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        outlineTextField(
                          keyboardType: TextInputType.multiline,
                          controller: _annoucementDescriptionController,
                          hintText: "Enter The Announcement Description",
                          isRequired: true,
                          maxLines: 3,
                          onChangeCallBack: (data) {
                            if (_annoucementTitleController.text.isEmpty ||
                                _annoucementDescriptionController
                                    .text.isEmpty) {
                              _askForVolunteersViewModel.enableButton(false);
                            } else {
                              {
                                _askForVolunteersViewModel.enableButton(true);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Available Volunteers Slots",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<AskForVolunteersViewModel>(
                          builder: (_, viewModel, child) {
                            if (viewModel.agendaWithNoRolePlayersList.isEmpty) {
                              return const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    "You Deleted All Un-Allocated Roles!, please make "
                                    "sure you at least have one slot for volunteers!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
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
                                  itemCount: viewModel.volunteersSlots.length,
                                  separatorBuilder: (_, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return availableVolunteersSlots(
                                        deleteAction: () {
                                          viewModel.deleteSlot(index);
                                        },
                                        role: viewModel
                                            .volunteersSlots[index].roleName,
                                        rolePlace: viewModel
                                            .volunteersSlots[index]
                                            .roleOrderPlace,
                                        slotStatus: viewModel
                                            .volunteersSlots[index].slotStatus);
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<AskForVolunteersViewModel>(
                          builder: (_, viewModel, child) {
                            return viewModel.enableAnnounceNowButton
                                ? filledTextButton(
                                    callBack: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_askForVolunteersViewModel
                                            .agendaWithNoRolePlayersList
                                            .isNotEmpty) {
                                          await _askForVolunteersViewModel
                                              .announceNeedOfVolunteers(
                                                  chapterMeetingId:
                                                      widget.chapterMeetingId,
                                                  annnoucementDescription:
                                                      _annoucementDescriptionController
                                                          .text,
                                                  annnoucementTitle:
                                                      _annoucementTitleController
                                                          .text)
                                              .then(
                                            (value) {
                                              value.when(
                                                (success) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    getSnackBar(
                                                      text: const Text(
                                                        "You have Successfully Announced The Volunteers Request",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              CommonUIProperties
                                                                  .fontType,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              AppMainColors
                                                                  .p90),
                                                        ),
                                                      ),
                                                      color: const Color(
                                                          AppMainColors
                                                              .successSnapBarMessage),
                                                    ),
                                                  );

                                                  context.popRoute();
                                                },
                                                (error) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    getSnackBar(
                                                      text: Text(
                                                        error.message,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              CommonUIProperties
                                                                  .fontType,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              AppMainColors
                                                                  .p90),
                                                        ),
                                                      ),
                                                      color: const Color(
                                                          AppMainColors
                                                              .warningError50),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        } else {
                                          //show warning message here
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            getSnackBar(
                                              text: const Text(
                                                "You can't Announce While not having any roles",
                                                style: TextStyle(
                                                  fontFamily: CommonUIProperties
                                                      .fontType,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      Color(AppMainColors.p90),
                                                ),
                                              ),
                                              color: const Color(
                                                  AppMainColors.warningError50),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    content: "Announce Now")
                                : outlinedButton(
                                    callBack: () {
                                      //do nothing
                                    },
                                    content: "Announce Now");
                          },
                        ),
                        // _enable
                      ],
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
