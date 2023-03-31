import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_coming_sessions_view_model.dart';

class CreateNewSessionDialog extends StatefulWidget {
  @override
  _CreateNewSessionDialog createState() => _CreateNewSessionDialog();
}

class _CreateNewSessionDialog extends State<CreateNewSessionDialog> {
  final TextEditingController _sessionTitle = TextEditingController();
  final TextEditingController _sessionDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _userUnformatedDate;
  late ManageComingSessionsViewModel _manageComingSessionsViewModel;

  @override
  Widget build(BuildContext context) {
    _manageComingSessionsViewModel = Provider.of<ManageComingSessionsViewModel>(
      context,
    );

    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text(
          'Create A New Session',
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.p80),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            outlineTextField(
                isRequired: true,
                controller: _sessionTitle,
                hintText: "Enter The Session Title",
                keyboardType: TextInputType.text),
            SizedBox(height: 16),
            outlineTextFieldWithTrailingIcon(
              isRequired: true,
              readOnly: true,
              controller: _sessionDate,
              hintText: "Enter Member Birth Date",
              onChangeCallBack: (data) {},
              onTapCallBack: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (data) {
                    _sessionDate.text =
                        DateFormat("h:mm a, EE, MMM d, yyyy").format(data);
                    _userUnformatedDate = data.toString();
                  },
                );
              },
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: Color(AppMainColors.p20),
              ),
            ),
          ],
        ),
        actions: [
          textButton(
            callBack: () {
              Navigator.of(context).pop();
            },
            content: const Text(
              "Cancel",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p50),
              ),
            ),
          ),
          filledTextButton(
              callBack: () async {
                if (_formKey.currentState!.validate()) {
                  await _manageComingSessionsViewModel
                      .createNewSession(_sessionTitle.text, _userUnformatedDate)
                      .then(
                        (_) => {
                          _manageComingSessionsViewModel
                              .getCreatedNewSessionsStatus
                              ?.whenError(
                            (error) => {
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
                              )
                            },
                          )
                        },
                      );
                  Navigator.of(context).pop();
                }
              },
              content: 'Confirm',
              buttonHeight: 40,
              buttonWidth: 90),
        ],
      ),
    );
  }
}
