import 'package:auto_route/auto_route.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
import 'package:speaxpoint/view_models/toastmaster_vm/profile_management_view_model.dart';

class ToastmasterProfileManagementScreen extends StatefulWidget {
  const ToastmasterProfileManagementScreen({super.key});

  @override
  State<ToastmasterProfileManagementScreen> createState() =>
      _ToastmasterProfileManagementScreenState();
}

class _ToastmasterProfileManagementScreenState
    extends State<ToastmasterProfileManagementScreen> {
  late ProfileManagementViewModel _profileManagementViewModel;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _currentPath = TextEditingController();
  final TextEditingController _currentProject = TextEditingController();
  final TextEditingController _currentLevel = TextEditingController();
  final TextEditingController _toastmasterName = TextEditingController();
  final TextEditingController _memberRole = TextEditingController();
  final TextEditingController _toastmasterUsername = TextEditingController();
  Gender _gender = Gender.noCurrentInput;

  bool _editDetailsMode = false;

  @override
  void dispose() {
    super.dispose();
    _dateOfBirth.dispose();
    _currentPath.dispose();
    _currentProject.dispose();
    _currentLevel.dispose();
    _toastmasterUsername.dispose();
    _toastmasterName.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileManagementViewModel =
        Provider.of<ProfileManagementViewModel>(context, listen: false);

    _profileManagementViewModel.getToastmasterDetails().then(
      (_) {
        _profileManagementViewModel.getToastmasterDetailsStatus?.when(
          (success) {
            _toastmasterName.text = success.toastmasterName!;
            _dateOfBirth.text = success.toastmasterBirthDate!;
            setState(() {
              _gender = success.gender! == Gender.male.name
                  ? Gender.male
                  : Gender.female;
            });

            _memberRole.text = success.memberOfficalRole!;
            _currentPath.text = success.currentPath!;
            _currentProject.text = success.currentProject!;
            _currentLevel.text = success.currentLevel!.toString();
            _toastmasterUsername.text = success.toastmasterUsername!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                _editDetailsMode ? Icons.check : Icons.edit,
                size: 28,
                color: const Color(AppMainColors.p50),
              ),
              onPressed: () async {
                //if in edit mode update , else add a new member
                setState(
                  () {
                    if (_editDetailsMode) {
                      if (_formKey.currentState!.validate()) {
                        _profileManagementViewModel
                            .updateUserDetails(
                          toastmasterName: _toastmasterName.text,
                          gender: _gender.name,
                          dataOfBirth: _dateOfBirth.text,
                          currentPath: _currentPath.text,
                          currentProject: _currentProject.text,
                          memberRole: _memberRole.text,
                          toastmasterUsername: _toastmasterUsername.text,
                          currentLevel: _currentLevel.text.isEmpty
                              ? 0
                              : int.parse(_currentLevel.text),
                        )
                            .then(
                          (_) {
                            _profileManagementViewModel
                                .updateToastmasterDetailsStatus
                                ?.when(
                              (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  getSnackBar(
                                    text: const Text(
                                      "You have Successfully updated your details",
                                      style: TextStyle(
                                        fontFamily: CommonUIProperties.fontType,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppMainColors.p90),
                                      ),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 103, 187, 106),
                                  ),
                                );
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
                                    color:
                                        const Color.fromARGB(255, 201, 79, 79),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    }
                    _editDetailsMode = !_editDetailsMode;
                  },
                );
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Manage Profile",
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
                        isRequired: _editDetailsMode,
                        readOnly: !_editDetailsMode,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Toastmaster Username",
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
                        controller: _toastmasterUsername,
                        hintText: "Enter Toastmaster Username",
                        isRequired: _editDetailsMode,
                        readOnly: !_editDetailsMode,
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
                        isRequired: _editDetailsMode,
                        readOnly: !_editDetailsMode,
                        controller: _dateOfBirth,
                        hintText: "Enter Member Birth Date",
                        onChangeCallBack: (data) {},
                        onTapCallBack: () {
                          if (_editDetailsMode) {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (data) {
                                _dateOfBirth.text =
                                    DateFormat.yMd().format(data);
                              },
                            );
                          }
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
                      text_field.outlineTextField(
                          controller: _memberRole,
                          hintText: "Member Role",
                          isRequired: false,
                          readOnly: true,
                          keyboardType: TextInputType.text),
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
                          isRequired: _editDetailsMode,
                          readOnly: !_editDetailsMode,
                          controller: _currentPath,
                          hintText: "Enter Member Current Path",
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
                        isRequired: _editDetailsMode,
                        readOnly: !_editDetailsMode,
                        keyboardType: TextInputType.text,
                        controller: _currentProject,
                        hintText: "Enter Member Current Project",
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
                        isRequired: _editDetailsMode,
                        readOnly: !_editDetailsMode,
                        keyboardType: TextInputType.number,
                        controller: _currentLevel,
                        hintText: "Enter Member Current Level",
                        onChangeCallBack: (data) {},
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
