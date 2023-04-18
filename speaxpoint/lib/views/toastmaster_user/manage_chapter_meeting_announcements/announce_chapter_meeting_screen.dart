import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';

class AnnounceChapterMeetingScreen extends StatefulWidget {
  const AnnounceChapterMeetingScreen({super.key});

  @override
  State<AnnounceChapterMeetingScreen> createState() =>
      _AnnounceChapterMeetingScreenState();
}

class _AnnounceChapterMeetingScreenState
    extends State<AnnounceChapterMeetingScreen> {
  final TextEditingController _anunBrochure = TextEditingController();
  final TextEditingController _anunTitle = TextEditingController();
  final TextEditingController _anunDescription = TextEditingController();
  final TextEditingController __anunContactNumber = TextEditingController();
  final TextEditingController _anunMeetingLink = TextEditingController();
  final TextEditingController _anunMeetingDate = TextEditingController();
  String _meetingRawDate = "";
  String _anunSelectType = "Public";
  bool _enableButton = false;
  List<Text> announcementType = [
    const Text(
      'Public',
      style: TextStyle(
        fontFamily: CommonUIProperties.fontType,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    ),
    const Text(
      'Private',
      style: TextStyle(
        fontFamily: CommonUIProperties.fontType,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    ),
  ];
  final List<bool> _selectedAnnouncement = [
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Color(AppMainColors.p70),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Announce Chapter Meeting",
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
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create New Announcement",
                  style: TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p90),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter the announcement details, that will be displayed to other app users.",
                  style: TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(AppMainColors.p50),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Announcement Brochure",
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
                outlineTextFieldWithTrailingIcon(
                  controller: _anunBrochure,
                  hintText: "Select Photo",
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                    color: Color(AppMainColors.p20),
                  ),
                  isRequired: false,
                  onChangeCallBack: (_) {},
                  onTapCallBack: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Title",
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
                  keyboardType: TextInputType.text,
                  controller: _anunTitle,
                  hintText: "Announcement Title",
                  isRequired: true,
                  onChangeCallBack: (_) {
                    setState(() {
                      _validateRequiredFields();
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description",
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
                  keyboardType: TextInputType.text,
                  controller: _anunDescription,
                  hintText: "Announcement Description",
                  isRequired: true,
                  maxLines: 3,
                  onChangeCallBack: (_) {
                    setState(() {
                      _validateRequiredFields();
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Meeting Date",
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
                outlineTextFieldWithTrailingIcon(
                  isRequired: true,
                  readOnly: true,
                  controller: _anunMeetingDate,
                  hintText: "Meeting Date",
                  onChangeCallBack: (_) {},
                  onTapCallBack: () {
                    DatePicker.showDateTimePicker(
                      context,
                      minTime: DateTime.now(),
                      showTitleActions: true,
                      onConfirm: (data) {
                        _anunMeetingDate.text =
                            DateFormat("E, d MMM, h:mm a").format(data);
                        setState(() {
                          _meetingRawDate = data.toString();
                          _validateRequiredFields();
                        });
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Color(AppMainColors.p20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Contact Number",
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
                  keyboardType: TextInputType.text,
                  controller: __anunContactNumber,
                  hintText: "Contact Number",
                  isRequired: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Meeting Link",
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
                  keyboardType: TextInputType.text,
                  controller: _anunMeetingLink,
                  hintText: "Meeting Link",
                  isRequired: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Announcement Type",
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
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (int index) {
                    setState(
                      () {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedAnnouncement.length; i++) {
                          _selectedAnnouncement[i] = i == index;
                        }
                        _anunSelectType = announcementType[index].data!;
                      },
                    );
                  },
                  borderRadius: const BorderRadius.all(
                      Radius.circular(CommonUIProperties.buttonRoundedEdges)),
                  selectedBorderColor: const Color(AppMainColors.p100),
                  selectedColor: Colors.white,
                  fillColor: const Color(AppMainColors.p100),
                  color: const Color(AppMainColors.p30),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedAnnouncement,
                  children: announcementType,
                ),
                const SizedBox(
                  height: 30,
                ),
                _enableButton
                    ? filledTextButton(callBack: () {}, content: "Announce Now")
                    : outlinedButton(callBack: () {}, content: "Announce Now"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateRequiredFields() {
    if (_anunTitle.text.isEmpty ||
        _anunDescription.text.isEmpty ||
        _meetingRawDate.isEmpty) {
      setState(
        () {
          _enableButton = false;
        },
      );
    } else {
      setState(
        () {
          _enableButton = true;
        },
      );
    }
  }
}
