import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widgets;
import 'package:speaxpoint/util/ui_widgets/navigation.dart' as navigation;
import 'package:speaxpoint/util/ui_widgets/type_selection_options.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_club_president/log_in_club_president.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_guest/log_in_guest.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_toastmaster.dart';

//TODO: in case there is a free time
/*
 is to add a warning message when the user click on outline continue button when
 there is not choice selected. the message can be a snackbar or text widget.
 */

class UserTypeSelection extends StatefulWidget {
  const UserTypeSelection({super.key});

  @override
  State<UserTypeSelection> createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection> {
  final List<String> _userTypes = ["Club President", "Club Member", "Guest"];

  int _selectedItem = -1;

  selectItem(index) {
    setState(() {
      _selectedItem = index;
    });
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
                      maxLines: 2,
                      "To continue please select your user type",
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
                    const Text(
                      "I am",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(AppMainColors.p90),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: ((context, index) {
                          return TypeSelectionOptions(selectItem,
                              index: index,
                              isSelected: _selectedItem == index,
                              displayOptions: _userTypes[index]);
                        }),
                      ),
                    )
                  ],
                ),
                _selectedItem > -1
                    ? ui_widgets.filledTextButton(callBack: 
                        () => {
                              //0 => presidnet . 1 => toastmaster , 2=>guest
                              if (_selectedItem == 0)
                                {
                                  navigation.navigateNewScreen(
                                      context, const LogInAsClubPresident())
                                }
                              else if (_selectedItem == 1)
                                {
                                  navigation.navigateNewScreen(
                                      context, const LogInAsToastmaster())
                                }
                              else if (_selectedItem == 2)
                                {
                                  navigation.navigateNewScreen(
                                      context, const LogInAsGuest())
                                }
                            },
                        content: "Continue")
                    : ui_widgets.outlinedButton(callBack: () => {}, content: "Continue"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
