import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/options_selections.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart' as text_field;
import 'package:speaxpoint/util/input_regex_validation.dart'
    as input_validators;
import 'package:speaxpoint/view_models/club_president_vm/manage_member_account_view_model.dart';
import 'package:auto_route/auto_route.dart';

class ManageMemberAccountScreen extends StatefulWidget {
  const ManageMemberAccountScreen(
      {super.key,
      required this.isInEditMode,
      required this.isTheUserPresidentl,
      this.userId});
  final bool isInEditMode;
  final bool isTheUserPresidentl;
  final String? userId;

  @override
  State<ManageMemberAccountScreen> createState() =>
      _ManageMemberAccountScreenState();
}

class _ManageMemberAccountScreenState extends State<ManageMemberAccountScreen> {
  late ManageMemberAccountViewModel _manageMemberAccountViewModel;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _currentPath = TextEditingController();
  final TextEditingController _currentProject = TextEditingController();
  final TextEditingController _currentLevel = TextEditingController();
  final TextEditingController _toastmasterName = TextEditingController();
  String _memberRole = StringUtils.capitalize(ToastmasterRoles.Member.name);
  Gender _gender = Gender.noCurrentInput;
  List<String> listOfRole = ToastmasterRoles.values
      .map((e) =>
          StringUtils.capitalize(e.name.replaceAll('_', ' '), allWords: true))
      .toList();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _dateOfBirth.dispose();
    _currentPath.dispose();
    _currentProject.dispose();
    _currentLevel.dispose();
  }

  @override
  void initState() {
    super.initState();
    _manageMemberAccountViewModel =
        Provider.of<ManageMemberAccountViewModel>(context, listen: false);
    if (widget.isInEditMode) {
      _manageMemberAccountViewModel
          .getToastmasterDetails(widget.userId!)
          .then((_) {
        _manageMemberAccountViewModel.getToastmasterDetailsStatus?.when(
          (success) {
            _toastmasterName.text = success.toastmasterName!;
            _dateOfBirth.text = success.toastmasterBirthDate!;
            _gender = success.gender! == Gender.male.name
                ? Gender.male
                : Gender.female;
            _memberRole = success.memberOfficalRole!;
            _currentPath.text = success.currentPath!;
            _currentProject.text = success.currentProject!;
            _currentLevel.text = success.currentLevel!.toString();
          },
          (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              getSnackBar(
                text: Text(
                  error.message,
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p90),
                  ),
                ),
                color: const Color.fromARGB(255, 201, 79, 79),
              ),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.check,
                size: 28,
                color: Color(AppMainColors.p50),
              ),
              onPressed: () async {
                //if in edit mode update , else add a new member
                if (widget.isInEditMode) {
                  if (_formKey.currentState!.validate()) {
                    await _manageMemberAccountViewModel
                        .updateUserDetails(
                      toastmasterId: widget.userId!,
                      toastmasterName: _toastmasterName.text,
                      memberRole: _memberRole,
                      gender: _gender.name,
                      dataOfBirth: _dateOfBirth.text,
                      currentPath: _currentPath.text,
                      currentProject: _currentProject.text,
                      currentLevel: _currentLevel.text.isEmpty
                          ? 0
                          : int.parse(_currentLevel.text),
                    )
                        .then(
                      (_) {
                        _manageMemberAccountViewModel
                            .updateToastmasterDetailsStatus
                            ?.when(
                          (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                    text: const Text(
                                      "You have Successfully updated the member details",
                                      style: TextStyle(
                                        fontFamily: CommonUIProperties.fontType,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppMainColors.p90),
                                      ),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 103, 187, 106)));

                            context.popRoute();
                          },
                          (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              getSnackBar(
                                text: Text(
                                  error.message,
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p90),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 201, 79, 79),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                } else {
                  if (_formKey.currentState!.validate()) {
                    await _manageMemberAccountViewModel
                        .registerNewClubMember(
                      email: _email.text,
                      password: _password.text,
                      toastmasterName: _toastmasterName.text,
                      memberRole: _memberRole,
                      currentLevel: _currentLevel.text.isEmpty
                          ? 0
                          : int.parse(_currentLevel.text),
                      currentPath: _currentPath.text,
                      currentProject: _currentProject.text,
                      gender: _gender.name,
                      dataOfBirth: _dateOfBirth.text,
                    )
                        .then(
                      (value) {
                        _manageMemberAccountViewModel.registrationStatus?.when(
                          (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                    text: const Text(
                                      "You have Successfully added a new member",
                                      style: TextStyle(
                                        fontFamily: CommonUIProperties.fontType,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppMainColors.p90),
                                      ),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 103, 187, 106)));
                            context.popRoute();
                          },
                          (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              getSnackBar(
                                text: Text(
                                  error.message,
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(AppMainColors.p90),
                                  ),
                                ),
                                color: const Color.fromARGB(255, 201, 79, 79),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
          leading: BackButton(
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
                      //these widget will only be displayed if it's in add mode
                      Visibility(
                          visible: !widget.isInEditMode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                keyboardType: TextInputType.text,
                                controller: _email,
                                onChangeCallBack: (data) {},
                                hintText: "Enter Member Email",
                                isRequired: !widget.isInEditMode,
                                readOnly: widget.isInEditMode,
                                validators: [
                                  input_validators.isValidEmail(
                                      _email.text.toString(), "invalid emails")
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
                                keyboardType: TextInputType.text,
                                controller: _password,
                                hintText: "Enter Member Password",
                                obscured: true,
                                isRequired: !widget.isInEditMode,
                                readOnly: widget.isInEditMode,
                                validators: [
                                  //to enter the password validator
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),

                      const Text(
                        "Toastmaster Name",
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
                        keyboardType: TextInputType.text,
                        controller: _toastmasterName,
                        hintText: "Enter Member Name",
                        isRequired: !widget.isInEditMode,
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
                        readOnly: true,
                        controller: _dateOfBirth,
                        hintText: "Enter Member Birth Date",
                        onChangeCallBack: (data) {},
                        onTapCallBack: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (data) {
                              _dateOfBirth.text = DateFormat.yMd().format(data);
                            },
                          );
                        },
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
                        "Member Role",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      dropdownMenu(
                          initialValue: _memberRole,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                            color: Color(AppMainColors.p20),
                          ),
                          items: listOfRole,
                          onChangeCallBack: (value) {
                            setState(() {
                              _memberRole = value!;
                            });
                          },
                          isRequired: true),
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
                          isRequired: false,
                          keyboardType: TextInputType.text),
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
                        keyboardType: TextInputType.text,
                        controller: _currentProject,
                        hintText: "Enter Member Current Project",
                        isRequired: false,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Current Level",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      text_field.outlineTextField(
                        keyboardType: TextInputType.number,
                        controller: _currentLevel,
                        hintText: "Enter Member Current Level",
                        onChangeCallBack: (data) {},
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
