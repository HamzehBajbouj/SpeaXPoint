import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/session_redirection_view_model.dart';

class ExitRedirectionScreenConfirmationDialog extends StatefulWidget {
  const ExitRedirectionScreenConfirmationDialog({
    super.key,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    required this.isAGuest,
  });

  final String? chapterMeetingId;
  final String? chapterMeetingInvitationCode;
  final bool isAGuest;

  @override
  State<ExitRedirectionScreenConfirmationDialog> createState() =>
      _ExitRedirectionScreenConfirmationDialogState();
}

class _ExitRedirectionScreenConfirmationDialogState
    extends State<ExitRedirectionScreenConfirmationDialog> {
  SessionRedirectionViewModel? _sessionRedirectionViewModel;
  LogInViewModel? _logInViewModel;
  bool _showErrorMessage = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sessionRedirectionViewModel =
        Provider.of<SessionRedirectionViewModel>(context, listen: false);
    _logInViewModel = Provider.of<LogInViewModel>(context, listen: false);
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
                  'Exiting The Session...',
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
                  "Are you sure you want to exit the meeting session?",
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
                    "An error occured while exiting the session, please try again..",
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
              Navigator.of(context).pop(false);
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
                setState(
                  () {
                    _isLoading = true;
                  },
                );
                await _sessionRedirectionViewModel
                    ?.leaveTheSession(
                  isAGuest: widget.isAGuest,
                  chapterMeetingId: widget.chapterMeetingId,
                  chapterMeetingInvitationCode:
                      widget.chapterMeetingInvitationCode,
                )
                    .then(
                  (value) {
                    value.when(
                      (success) async {
                        setState(
                          () {
                            _showErrorMessage = false;
                          },
                        );
                        if (widget.isAGuest) {
                          await _logInViewModel!.logOut().then(
                            (value) {
                              value.when(
                                (_) {
                                  Navigator.of(context).pop(true);
                                },
                                (_) {
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
                        } else {
                          Navigator.of(context).pop(true);
                        }
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
