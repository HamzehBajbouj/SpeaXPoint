import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widgets;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_fields;
import 'package:speaxpoint/util/ui_widgets/type_selection_options.dart';
import 'package:auto_route/auto_route.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';

class LogInAsGuestScreen extends StatefulWidget {
  const LogInAsGuestScreen({super.key});

  @override
  State<LogInAsGuestScreen> createState() => _LogInAsGuestState();
}

class _LogInAsGuestState extends State<LogInAsGuestScreen> {
  LogInViewModel? _logInViewModel;
  final TextEditingController _invitationCode = TextEditingController();
  final List<String> _sectionOptions = ["Yes", "No"];
  int _selectedItem = -1;
  String buttonLabel = "Join Now";
  bool _enableContinueButton = false;
  String errorMessage = "";
  bool showErrorMessage = false;
  @override
  void initState() {
    super.initState();
    _logInViewModel = Provider.of<LogInViewModel>(context, listen: false);
    _logInViewModel!.logInAnonymously();
  }

  @override
  void dispose() {
    super.dispose();
    _invitationCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: const Color(AppMainColors.backgroundAndContent),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      Text(
                        "SpeaXPoint",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 41,
                          fontWeight: FontWeight.w600,
                          color: Color(AppMainColors.p100),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        maxLines: 2,
                        "As a Guest are you volunteered to a role?",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: ((context, index) {
                            return TypeSelectionOptions(selectItem,
                                index: index,
                                isSelected: _selectedItem == index,
                                displayOptions: _sectionOptions[index]);
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Please Enter Chapter Invitation Code",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      text_fields.outlineTextField(
                        keyboardType: TextInputType.text,
                        controller: _invitationCode,
                        hintText: "Enter Your Invitation Code",
                        isRequired: true,
                        onChangeCallBack: (data) {
                          setState(
                            () {
                              if (_invitationCode.text.isNotEmpty) {
                                _enableContinueButton = true;
                              } else {
                                _enableContinueButton = false;
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: showErrorMessage,
                        child: Text(
                          errorMessage,
                          style: const TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.warningError75),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _selectedItem > -1 && _enableContinueButton
                      ? ui_widgets.filledTextButton(
                          callBack: () async {
                            setState(
                              () {
                                showErrorMessage = false;
                                errorMessage = "";
                              },
                            );
                            //0 => yes . 1 => no
                            if (_selectedItem == 0) {
                              await _logInViewModel!
                                  .validateChapterMeetingInvitationCode(
                                chapterMeetingInvitationCode:
                                    _invitationCode.text,
                              )
                                  .then(
                                (value) {
                                  value.when(
                                    (success) {
                                      context.pushRoute(
                                        GuestRoleInvitationCodeRouter(
                                            chapterMeetingInvitationCode:
                                                _invitationCode.text),
                                      );
                                    },
                                    (error) {
                                      setState(
                                        () {
                                          showErrorMessage = true;
                                          if (error.code ==
                                              "Session-Has-Not-Started") {
                                            errorMessage = error.message;
                                          } else if (error.code ==
                                              "No-Chapter-Meeting-Found") {
                                            errorMessage = error.message;
                                          } else {
                                            errorMessage =
                                                "An error occured while validating the chapter invitation code, please try again..";
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            } else if (_selectedItem == 1) {
                              await _logInViewModel!
                                  .validateChapterMeetingInvitationCode(
                                chapterMeetingInvitationCode:
                                    _invitationCode.text,
                              )
                                  .then(
                                (value) {
                                  value.when(
                                    (success) {
                                      context.replaceRoute(
                                        SessionRedirectionRouter(
                                          chapterMeetingInvitationCode:
                                              _invitationCode.text,
                                          isAGuest: true,
                                          guestHasRole: false,
                                        ),
                                      );
                                    },
                                    (error) {
                                      setState(
                                        () {
                                          showErrorMessage = true;
                                          if (error.code ==
                                              "Session-Has-Not-Started") {
                                            errorMessage = error.message;
                                          } else if (error.code ==
                                              "No-Chapter-Meeting-Found") {
                                            errorMessage = error.message;
                                          } else {
                                            errorMessage =
                                                "An error occured while validating the chapter invitation code, please try again..";
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                          content: buttonLabel)
                      : ui_widgets.outlinedButton(
                          callBack: () {}, content: buttonLabel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    await _logInViewModel!.logOut();
    return true;
  }

  selectItem(index) {
    setState(
      () {
        _selectedItem = index;
        if (_selectedItem == 0) {
          buttonLabel = "Continue";
        } else if (_selectedItem == 1) {
          buttonLabel = "Join Now";
        }
      },
    );
  }
}
