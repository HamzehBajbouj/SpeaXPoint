import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/input_regex_validation.dart'
    as input_validators;
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widget;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_field;
import 'package:speaxpoint/view_models/authentication_view_models/club_registration_view_model.dart';
import 'package:auto_route/auto_route.dart';

class ClubRegistrationScreen extends StatefulWidget {
  const ClubRegistrationScreen({super.key});

  @override
  State<ClubRegistrationScreen> createState() => _ClubRegistrationState();
}

class _ClubRegistrationState extends State<ClubRegistrationScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  bool _enable = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ClubRegistrationViewModel clubRegistrationViewModel =
        Provider.of<ClubRegistrationViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.97,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Register your club now to join hundreds of other clubs.",
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Please enter your log in details",
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
                        text_field.outlineTextField(
                            onChangeCallBack: () {
                              if (_email.text.isEmpty ||
                                  _password.text.isEmpty ||
                                  _confirmpassword.text.isEmpty) {
                                _enable = false;
                              } else {
                                {
                                  _enable = true;
                                }
                              }
                              setState(() {});
                            },
                            controller: _email,
                            hintText: "Enter Your Email",
                            isRequired: true,
                            validators: [
                              input_validators.isValidEmail(
                                  _email.text, "invalid emails")
                            ]),
                        const SizedBox(
                          height: 15,
                        ),
                        text_field.outlineTextField(
                          onChangeCallBack: () {
                            if (_email.text.isEmpty ||
                                _password.text.isEmpty ||
                                _confirmpassword.text.isEmpty) {
                              _enable = false;
                            } else {
                              {
                                _enable = true;
                              }
                            }
                            setState(() {});
                          },
                          controller: _password,
                          hintText: "Enter Your Password",
                          isRequired: true,
                          obscured: true,
                          validators: [
                            input_validators.confirmPasswordMatching(
                                _password.text,
                                _confirmpassword.text,
                                "unmatched passwords")
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        text_field.outlineTextField(
                          onChangeCallBack: () {
                            if (_email.text.isEmpty ||
                                _password.text.isEmpty ||
                                _confirmpassword.text.isEmpty) {
                              _enable = false;
                            } else {
                              {
                                _enable = true;
                              }
                            }
                            setState(() {});
                          },
                          controller: _confirmpassword,
                          hintText: "Confirm Your Password",
                          isRequired: true,
                          obscured: true,
                          validators: [
                            input_validators.confirmPasswordMatching(
                                _password.text,
                                _confirmpassword.text,
                                "unmatched passwords")
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Consumer<ClubRegistrationViewModel>(
                          builder: (_, value, child) {
                            return Text(
                                value.registrationStatus?.whenError((error) {
                                      // FirebaseAuthException cc =
                                      //     error as FirebaseAuthException;
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
                    Column(
                      children: [
                        _enable
                            ? ui_widget.filledTextButton(
                                callBack: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await clubRegistrationViewModel
                                        .registerNewClub(
                                      email: _email.text,
                                      password: _password.text,
                                    );

                                    clubRegistrationViewModel.registrationStatus
                                        ?.whenSuccess((_) {
                                      context.router.pushAndPopUntil(
                                          const ClubUsernameRegistrationRouter(),
                                          predicate: ModalRoute.withName(
                                              ClubPresidentLoginRouter.name));
                                    });
                                  }
                                },
                                content: "Register Now")
                            : ui_widget.outlinedButton(
                                callBack: () {}, content: "Register Now"),
                        const SizedBox(
                          height: 15,
                        ),
                        ui_widget.outlinedIconTextButton(
                            callBack: () {
                              context.router.pop();
                            },
                            content: "Previous Page",
                            icon: Icons.arrow_back),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
