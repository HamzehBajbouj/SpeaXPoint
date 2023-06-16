import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speaxpoint/models/club_account.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/input_regex_validation.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_profile_view_model.dart';

class EditClubProfileDetailsScreen extends StatefulWidget {
  const EditClubProfileDetailsScreen({super.key});

  @override
  State<EditClubProfileDetailsScreen> createState() =>
      _EditClubProfileDetailsScreenState();
}

class _EditClubProfileDetailsScreenState
    extends State<EditClubProfileDetailsScreen> {
  final TextEditingController _profilePhoto = TextEditingController();
  final TextEditingController _profileBackgoundPhoto = TextEditingController();
  final TextEditingController _clubName = TextEditingController();
  final TextEditingController _profileDescription = TextEditingController();
  final TextEditingController _overviewTitle = TextEditingController();
  final TextEditingController _overviewDescription = TextEditingController();
  final TextEditingController _websiteLink = TextEditingController();
  final TextEditingController _contactNumber = TextEditingController();
  final TextEditingController _clubLocationLink = TextEditingController();
  final TextEditingController _clubOfficialEmail = TextEditingController();
  File? profilePhotoFile;
  File? profileBackgroundPhoto;
  bool _clubProfileHasPhoto = false;
  bool _clubProfileHasBackgound = false;
  bool disableButton = false;
  final _formKey = GlobalKey<FormState>();
  bool _loading = true;
  late ClubProfileViewModel _clubProfileViewModel;

  @override
  void initState() {
    super.initState();
    _clubProfileViewModel =
        Provider.of<ClubProfileViewModel>(this.context, listen: false);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    ClubAccount? clubAccount = await _clubProfileViewModel
        .getClubDetails(getClubIdFromLocalDatabase: true)
        .timeout(const Duration(seconds: 10));
    if (clubAccount == null) {
      setState(
        () {
          _loading = false;
        },
      );
    } else {
      setState(
        () {
          _loading = false;
          if (clubAccount.clubProfileWasSetUp ?? false) {
            _clubProfileHasPhoto = clubAccount.profileImageURL == null;
            _clubProfileHasBackgound = clubAccount.backgroundImageURL == null;
            _clubName.text = clubAccount.clubName ?? "";
            _profileDescription.text = clubAccount.profileDescription ?? "";
            _overviewTitle.text = clubAccount.clubOverviewTitle ?? "";
            _overviewDescription.text =
                clubAccount.clubOverviewDescription ?? "";
            _websiteLink.text = clubAccount.webSiteLink ?? "";
            _contactNumber.text = clubAccount.clubPhoneNumber ?? "";
            _clubLocationLink.text = clubAccount.clubLocationLink ?? "";
            _clubOfficialEmail.text = clubAccount.officialEmail ?? "";
          }
        },
      );
    }
  }

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
          "Edit Club Profile",
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
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(AppMainColors.p40),
                ),
              )
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 25),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Edit Club Profile",
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
                          "Enter the club profile details that you want it to be display to other users.",
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
                          "Profile Photo",
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
                          controller: _profilePhoto,
                          hintText: "Select Photo",
                          readOnly: true,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                            color: Color(AppMainColors.p20),
                          ),
                          isRequired: _clubProfileHasPhoto,
                          onChangeCallBack: (_) {},
                          onTapCallBack: () async {
                            try {
                              final pickedPhoto = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedPhoto != null) {
                                profilePhotoFile = File(pickedPhoto.path);
                                _profilePhoto.text =
                                    basename(profilePhotoFile!.path);
                              } else {
                                setState(
                                  () {
                                    _profilePhoto.text = "";
                                  },
                                );
                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  const SnackBar(
                                    content: Text("No Image Is Selected!"),
                                  ),
                                );
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Profile Background Photo",
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
                          controller: _profileBackgoundPhoto,
                          hintText: "Select Photo",
                          readOnly: true,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 30,
                            color: Color(AppMainColors.p20),
                          ),
                          isRequired: _clubProfileHasBackgound,
                          onChangeCallBack: (_) {},
                          onTapCallBack: () async {
                            try {
                              final pickedPhoto = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedPhoto != null) {
                                profileBackgroundPhoto = File(pickedPhoto.path);
                                _profileBackgoundPhoto.text =
                                    basename(profileBackgroundPhoto!.path);
                              } else {
                                setState(
                                  () {
                                    _profileBackgoundPhoto.text = "";
                                  },
                                );
                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  const SnackBar(
                                    content: Text("No Image Is Selected!"),
                                  ),
                                );
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Club Name",
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
                          controller: _clubName,
                          hintText: "Club Name",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Profile Description",
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
                          controller: _profileDescription,
                          hintText: "Profile Description",
                          isRequired: true,
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Club Overview",
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
                          controller: _overviewTitle,
                          hintText: "Overview Title",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        outlineTextField(
                          keyboardType: TextInputType.text,
                          controller: _overviewDescription,
                          hintText: "Overview Description",
                          isRequired: true,
                          maxLines: 3,
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
                          keyboardType: TextInputType.number,
                          controller: _contactNumber,
                          hintText: "Club Contact Number",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Official Email",
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
                          controller: _clubOfficialEmail,
                          hintText: "Club Official Email",
                          isRequired: true,
                          validators: [
                            isValidEmail(
                                _clubOfficialEmail.text, "invalid emails")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Website Link",
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
                          controller: _websiteLink,
                          hintText: "Club Website Link",
                          isRequired: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Club Location",
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
                          controller: _clubLocationLink,
                          hintText: "Club Location",
                          isRequired: false,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        disableButton
                            ? outlinedButton(
                                callBack: () {}, content: "updating...")
                            : filledTextButton(
                                callBack: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(
                                      () {
                                        disableButton = true;
                                      },
                                    );
                                    await _clubProfileViewModel
                                        .updateClubProfileDetails(
                                      clubName: _clubName.text,
                                      profileDescription:
                                          _profileDescription.text,
                                      overviewTitle: _overviewTitle.text,
                                      overviewDescription:
                                          _overviewDescription.text,
                                      contactNumber: _contactNumber.text,
                                      officialEmail: _clubOfficialEmail.text,
                                      locationLink:
                                          _clubLocationLink.text.isEmpty
                                              ? null
                                              : _clubLocationLink.text,
                                      websiteLink: _websiteLink.text.isEmpty
                                          ? null
                                          : _websiteLink.text,
                                      profileBackground: profileBackgroundPhoto,
                                      profilePhoto: profilePhotoFile,
                                    )
                                        .then(
                                      (value) {
                                        value.when(
                                          (success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              getSnackBar(
                                                text: const Text(
                                                  "Profile has been updated successfully.",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        CommonUIProperties
                                                            .fontType,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(
                                                        AppMainColors.p90),
                                                  ),
                                                ),
                                                color: const Color(AppMainColors
                                                    .successSnapBarMessage),
                                              ),
                                            );
                                            context.popRoute();
                                          },
                                          (error) {
                                            setState(
                                              () {
                                                disableButton = false;
                                              },
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              getSnackBar(
                                                text: Text(
                                                  "Error : ${error.message}",
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        CommonUIProperties
                                                            .fontType,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(AppMainColors
                                                        .backgroundAndContent),
                                                  ),
                                                ),
                                                color: const Color(AppMainColors
                                                    .warningError75),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                                content: "Update Now"),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
