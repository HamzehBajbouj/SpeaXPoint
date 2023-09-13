import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/scheduled_meetings_view_model.dart';

class JoinSessionConfirmationDialog extends StatefulWidget {
  const JoinSessionConfirmationDialog({
    super.key,
    required this.chapterMeetingId,
  });

  final String chapterMeetingId;

  @override
  State<JoinSessionConfirmationDialog> createState() =>
      _JoinSessionConfirmationDialogState();
}

class _JoinSessionConfirmationDialogState
    extends State<JoinSessionConfirmationDialog> {
  ScheduledMeetingsViewModel? _scheduledMeetingsViewModel;
  bool _showErrorMessage = false;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _scheduledMeetingsViewModel =
        Provider.of<ScheduledMeetingsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _isLoading
          ? null
          : const Text(
              'Warning !',
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.warningError75),
              ),
            ),
      content: _isLoading
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  color: Color(AppMainColors.p40),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Joining...',
                  style: TextStyle(
                    height: 1.4,
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(AppMainColors.p70),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure you want to join the chapter meeting session?",
                  style: TextStyle(
                    height: 1.4,
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(AppMainColors.p70),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: _showErrorMessage,
                  child: const Text(
                    "An error occured while joing the session, please try again..",
                    style: TextStyle(
                      height: 1.4,
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.warningError75),
                    ),
                  ),
                ),
              ],
            ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Visibility(
          visible: !_isLoading,
          child: textButton(
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
        ),
        Visibility(
          visible: !_isLoading,
          child: filledTextButton(
              callBack: () async {
                setState(() {
                  _isLoading = true;
                });
                await _scheduledMeetingsViewModel
                    ?.joinSession(chapterMeetingId: widget.chapterMeetingId)
                    .then(
                  (value) {
                    value.when(
                      (success) {
                        setState(
                          () {
                            _showErrorMessage = false;
                          },
                        );
                        Navigator.of(context).pop(true);
                      },
                      (error) {
                        setState(
                          () {
                            _showErrorMessage = true;
                            _isLoading = false;
                          },
                        );
                      },
                    );
                  },
                );
              },
              content: 'Confirm',
              buttonHeight: 40,
              buttonWidth: 90),
        ),
      ],
    );
  }
}
