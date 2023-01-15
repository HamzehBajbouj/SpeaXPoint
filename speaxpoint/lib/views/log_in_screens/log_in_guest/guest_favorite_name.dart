import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widgets;
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_fields;
import 'package:speaxpoint/util/ui_widgets/type_selection_options.dart';
import 'package:speaxpoint/util/ui_widgets/navigation.dart' as navigation;

class GuestFavoriteName extends StatefulWidget {
  const GuestFavoriteName({super.key, required this.guestHasRole});

  final bool guestHasRole;
  @override
  State<GuestFavoriteName> createState() => _GuestFavoriteNameState();
}

class _GuestFavoriteNameState extends State<GuestFavoriteName> {
  final TextEditingController _guestName = TextEditingController();
  bool _enableContinueButton = false;
  final _formKey = GlobalKey<FormState>();
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
                        "Please enter your favorite name",
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
                        "Your name will be displayed to other\n audience.",
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
                          controller: _guestName,
                          hintText: "Enter Your Invitation Code",
                          isRequired: true,
                          onChangeCallBack: () {
                            if (_guestName.text.isNotEmpty) {
                              _enableContinueButton = true;
                              setState(() {});
                            }
                          }),
                    ],
                  ),
                  _enableContinueButton
                      ? ui_widgets.filledTextButton(
                          callBack: () => {}, content: "Join Now")
                      : ui_widgets.outlinedButton(
                          callBack: () => {}, content: "Join Now"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
