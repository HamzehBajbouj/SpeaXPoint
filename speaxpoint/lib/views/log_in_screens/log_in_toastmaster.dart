import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/input_regex_validation.dart'
    as input_validators;
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widget;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_field;

class LogInAsToastmaster extends StatefulWidget {
  const LogInAsToastmaster({super.key});

  @override
  State<LogInAsToastmaster> createState() => _LogInAsToastmasterState();
}

class _LogInAsToastmasterState extends State<LogInAsToastmaster> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _enable = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: const Color(AppMainColors.backgroundAndContent),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
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
                            if (_email.text.isEmpty || _password.text.isEmpty) {
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
                            if (_email.text.isEmpty || _password.text.isEmpty) {
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
                          obscured: true),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "If you don't have an account, please reach out to your club president.",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    ],
                  ),
                  _enable
                      ? ui_widget.filledTextButton(
                          callBack: () {
                            if (_formKey.currentState!.validate()) 
                            {
                              
                            }
                          },
                          content: "Sign In")
                      : ui_widget.outlinedButton(
                          callBack: () {}, content: "Sign In")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
