import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widgets;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_fields;
import 'package:speaxpoint/util/ui_widgets/type_selection_options.dart';
import 'package:auto_route/auto_route.dart';

class LogInAsGuestScreen extends StatefulWidget {
  const LogInAsGuestScreen({super.key});

  @override
  State<LogInAsGuestScreen> createState() => _LogInAsGuestState();
}

class _LogInAsGuestState extends State<LogInAsGuestScreen> {
  final TextEditingController _invitationCode = TextEditingController();
  final List<String> _sectionOptions = ["Yes", "No"];
  int _selectedItem = -1;

  bool _enableContinueButton = false;
  final _formKey = GlobalKey<FormState>();
  selectItem(index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  void dispose() {
    _invitationCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        "Please Enter your invitation code",
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
                          controller: _invitationCode,
                          hintText: "Enter Your Invitation Code",
                          isRequired: true,
                          onChangeCallBack: () {
                            if (_invitationCode.text.isNotEmpty) {
                              _enableContinueButton = true;
                              setState(() {});
                            }
                          }),
                    ],
                  ),
                  _selectedItem > -1 && _enableContinueButton
                      ? ui_widgets.filledTextButton(
                          callBack: () => {
                                //0 => yes . 1 => no
                                if (_selectedItem == 0)
                                  {
                                    //if volunteered direct pass the true to the next page
                                    context.router
                                        .pushNamed("favoriteName/true")
                                  }
                                else if (_selectedItem == 1)
                                  {
                                    //if volunteered direct pass the false to the next page
                                    context.router
                                        .pushNamed("favoriteName/false")
                                  }
                              },
                          content: "Continue")
                      : ui_widgets.outlinedButton(
                          callBack: () => {}, content: "Continue"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
