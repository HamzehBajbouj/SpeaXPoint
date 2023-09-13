import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widgets;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_fields;
import 'package:auto_route/auto_route.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';

class GuestRoleInvitationCodeScreen extends StatefulWidget {
  const GuestRoleInvitationCodeScreen({
    super.key,
    required this.chapterMeetingInvitationCode,
  });

  final String chapterMeetingInvitationCode;
  @override
  State<GuestRoleInvitationCodeScreen> createState() =>
      _GuestFavoriteNameState();
}

class _GuestFavoriteNameState extends State<GuestRoleInvitationCodeScreen> {
  LogInViewModel? _logInViewModel;
  final TextEditingController _guestInvitationCodeController =
      TextEditingController();
  String errorMessage = "";
  bool showErrorMessage = false;
  bool _enableContinueButton = false;
  @override
  void initState() {
    super.initState();
    _logInViewModel = Provider.of<LogInViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Please enter your guest invitation code",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p80),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "This code is given to by the VPE which is associated to your role.",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p50),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    text_fields.outlineTextField(
                      keyboardType: TextInputType.text,
                      controller: _guestInvitationCodeController,
                      hintText: "Enter Your Guest Code",
                      isRequired: true,
                      onChangeCallBack: (data) {
                        setState(
                          () {
                            if (_guestInvitationCodeController
                                .text.isNotEmpty) {
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
                _enableContinueButton
                    ? ui_widgets.filledTextButton(
                        callBack: () async {
                          await _logInViewModel!
                              .validateRoleInvitationCode(
                                  chapterMeetingInvitationCode:
                                      widget.chapterMeetingInvitationCode,
                                  guestRoleInvitationCode:
                                      _guestInvitationCodeController.text)
                              .then(
                            (value) {
                              value.when(
                                (success) async {
                                  await _logInViewModel!
                                      .increaseOnlinePeopleCounterForLoggedGuests(
                                          chapterMeetingInvitationCode: widget
                                              .chapterMeetingInvitationCode)
                                      .then(
                                    (value) {
                                      context.router.pushAndPopUntil(
                                        SessionRedirectionRouter(
                                            chapterMeetingInvitationCode: widget
                                                .chapterMeetingInvitationCode,
                                            isAGuest: true,
                                            guestHasRole: true,
                                            guestInvitationCode:
                                                _guestInvitationCodeController
                                                    .text),
                                        predicate: ModalRoute.withName(
                                            UserTypeSelectionRouter.name),
                                      );
                                    },
                                  );
                                },
                                (error) {
                                  setState(
                                    () {
                                      showErrorMessage = true;
                                      if (error.code == "No-Guest-Role-Found") {
                                        errorMessage = error.message;
                                      } else {
                                        errorMessage =
                                            "An error occured while validating the role invitation code, please try again..";
                                      }
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                        content: "Join Now")
                    : ui_widgets.outlinedButton(
                        callBack: () {}, content: "Join Now"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
