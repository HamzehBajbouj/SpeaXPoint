import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

class SessionCompletionCounterDialog extends StatefulWidget {
  const SessionCompletionCounterDialog({
    super.key,
  });

  @override
  State<SessionCompletionCounterDialog> createState() =>
      _SessionCompletionCounterDialogState();
}

class _SessionCompletionCounterDialogState
    extends State<SessionCompletionCounterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Warning !',
        style: TextStyle(
          fontFamily: CommonUIProperties.fontType,
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Color(AppMainColors.warningError75),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "The Session Has Been Ended By The VPE, You Will Be Exiting the Meeting Within",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color(AppMainColors.p70),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<int>(
            stream: countdownStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final count = snapshot.data!;
                if (count == 0) {
                  Navigator.pop(context);
                }
                return Text(
                  count.toString(),
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(AppMainColors.p90),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Stream<int> countdownStream() {
    const duration = Duration(seconds: 1);
    const countdownStart = 7;
    final controller = StreamController<int>();

    Timer.periodic(duration, (timer) {
      final count = countdownStart - timer.tick;
      if (count >= 0) {
        controller.add(count);
      } else {
        controller.close();
        timer.cancel();
      }
    });
    return controller.stream;
  }
}
