import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widgets;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_fields;
import 'package:speaxpoint/view_models/authentication_view_models/club_registration_view_model.dart';
import 'package:auto_route/auto_route.dart';

class ClubUsernameRegistrationScreen extends StatefulWidget {
  const ClubUsernameRegistrationScreen({super.key});

  @override
  State<ClubUsernameRegistrationScreen> createState() =>
      _ClubUsernameRegistrationState();
}

class _ClubUsernameRegistrationState
    extends State<ClubUsernameRegistrationScreen> {
  final TextEditingController _username = TextEditingController();
  bool _enableProcessedButton = false;
  bool _userHasAusername = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ClubRegistrationViewModel clubRegistrationViewModel =
        Provider.of<ClubRegistrationViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "SpeaXPoint",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 41,
                            fontWeight: FontWeight.w600,
                            color: Color(AppMainColors.p100),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Allow other users to easily find your club. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Please enter your club username",
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
                        "*Your club username will be visible to other users.",
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
                        controller: _username,
                        hintText: "Enter Your Club's Username",
                        isRequired: true,
                        onChangeCallBack: () {
                          if (_username.text.isNotEmpty) {
                            setState(() {
                              _enableProcessedButton = true;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<ClubRegistrationViewModel>(
                        builder: (_, value, child) {
                          return Text(
                              value.clubUsernameRegistrationStatus
                                      ?.whenError((error) {
                                    if (error.code == "username-existed") {
                                      _userHasAusername = true;
                                    }
                                    clubRegistrationViewModel
                                        .clubUsernameRegistrationStatus = null;

                                    return error.message;
                                  }) ??
                                  "",
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(AppMainColors.warningError75),
                              ));
                        },
                      ),
                    ],
                  ),
                  _enableProcessedButton
                      ? ui_widgets.filledTextButton(
                          callBack: () async {
                            if (_userHasAusername) {
                              context.router.pushAndPopUntil(
                                  const ClubSetUpRegistrationRouter(),
                                  predicate: ModalRoute.withName(
                                      ClubUsernameRegistrationRouter.name));
                            }
                            if (_formKey.currentState!.validate()) {
                              await clubRegistrationViewModel
                                  .registerClubUsername(
                                      username: _username.text);
                              clubRegistrationViewModel
                                  .clubUsernameRegistrationStatus
                                  ?.whenSuccess((_) {
                                context.router.pushAndPopUntil(
                                    const ClubSetUpRegistrationRouter(),
                                    predicate: ModalRoute.withName(
                                        ClubUsernameRegistrationRouter.name));
                              });
                            }
                          },
                          content: "Register Now")
                      : ui_widgets.outlinedButton(
                          callBack: () => {}, content: "Processed"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
