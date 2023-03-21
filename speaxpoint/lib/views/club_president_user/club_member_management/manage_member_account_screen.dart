import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:auto_route/auto_route.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/radio_options.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_field;
import 'package:speaxpoint/util/input_regex_validation.dart'
    as input_validators;

class ManageMemberAccountScreen extends StatefulWidget {
  const ManageMemberAccountScreen({
    super.key,
    required this.isInEditMode,
    required this.isTheUserPresidentl,
  });
  final bool isInEditMode;
  final bool isTheUserPresidentl;

  @override
  State<ManageMemberAccountScreen> createState() =>
      _ManageMemberAccountScreenState();
}

class _ManageMemberAccountScreenState extends State<ManageMemberAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _currentPath = TextEditingController();
  final TextEditingController _currentProject = TextEditingController();
  final TextEditingController _currentLevel = TextEditingController();
  Gender _gender = Gender.noCurrentInput;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _dateOfBirth.dispose();
    _currentPath.dispose();
    _currentProject.dispose();
    _currentLevel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //https://stackoverflow.com/questions/71233179/how-can-i-call-my-provider-model-into-initstate-method

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                widget.isInEditMode ? Icons.edit : Icons.check,
                size: 28,
                color: Color(AppMainColors.p50),
              ),
              onPressed: () {
                // Add your submit button logic here
                if (widget.isInEditMode) {
                } else {
                  if (_formKey.currentState!.validate()) {

                  }
                }
              },
            ),
          ],
          leading: const BackButton(
            color: Color(AppMainColors.p70),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.isInEditMode ? "Edit Member Info" : "Add New Member",
            style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p70),
            ),
          ),
        ),
        backgroundColor: Color(AppMainColors.backgroundAndContent),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.shortestSide /
                                        2,
                                  ),
                                  border: Border.all(
                                    color: const Color(
                                        AppMainColors.backgroundAndContent),
                                    width: 7.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.16),
                                      spreadRadius: 0,
                                      blurRadius: 24,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.shortestSide /
                                        2,
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl:
                                        "https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg",
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(
                                          AppMainColors.backgroundAndContent),
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.shortestSide /
                                          2,
                                    ),
                                    color: const Color(AppMainColors.p80),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      iconSize: 20,
                                      icon: const Icon(
                                          color: Color(AppMainColors
                                              .backgroundAndContent),
                                          Icons.camera_alt_outlined),
                                      onPressed: () {
                                        // add photo functionality
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Email",
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
                      text_field.outlineTextField(
                        controller: _email,
                        hintText: "Enter Member Email",
                        onChangeCallBack: () {},
                        isRequired: true,
                        validators: [
                          input_validators.isValidEmail(
                              _email.text, "invalid emails")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Password",
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
                      text_field.outlineTextField(
                        controller: _password,
                        hintText: "Enter Member Password",
                        obscured: true,
                        onChangeCallBack: () {},
                        isRequired: true,
                        validators: [
                          //to enter the password validator
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Date of Birth",
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
                      text_field.outlineTextFieldWithTrailingIcon(
                        controller: _dateOfBirth,
                        hintText: "Enter Member Birth Date",
                        onChangeCallBack: () {},
                        onTapCallBack: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Color(AppMainColors.p20),
                        ),
                        isRequired: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Gender",
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
                      Row(
                        children: [
                          genderRadioOption(
                            selected: _gender == Gender.male ? true : false,
                            onChanged: (selectd) {
                              setState(() {
                                if (selectd) {
                                  _gender = Gender.male;
                                }
                              });
                            },
                            text: Text(
                              "Male",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: CommonUIProperties.fontType,
                                fontWeight: FontWeight.normal,
                                color: _gender == Gender.male
                                    ? Color(AppMainColors.p80)
                                    : Color(AppMainColors.p30),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          genderRadioOption(
                            selected: _gender == Gender.female ? true : false,
                            onChanged: (selectd) {
                              setState(
                                () {
                                  if (selectd) {
                                    _gender = Gender.female;
                                  }
                                },
                              );
                            },
                            text: Text(
                              "Female",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: CommonUIProperties.fontType,
                                fontWeight: FontWeight.normal,
                                color: _gender == Gender.female
                                    ? Color(AppMainColors.p80)
                                    : Color(AppMainColors.p30),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Current Path",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      text_field.outlineTextField(
                        controller: _currentPath,
                        hintText: "Enter Member Current Path",
                        obscured: true,
                        onChangeCallBack: () {},
                        isRequired: false,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Current Project",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      text_field.outlineTextField(
                        controller: _currentProject,
                        hintText: "Enter Member Current Project",
                        obscured: true,
                        onChangeCallBack: () {},
                        isRequired: false,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Current Project",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      text_field.outlineTextField(
                        controller: _currentLevel,
                        hintText: "Enter Member Current Level",
                        obscured: true,
                        onChangeCallBack: () {},
                        isRequired: false,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
