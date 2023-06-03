import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speaxpoint/util/ui_widgets/common_manipluating_methods.dart';
import 'package:speaxpoint/util/ui_widgets/common_widgets.dart';

class TimeCounterBar extends StatefulWidget {
  const TimeCounterBar(
      {super.key, required this.startTimeStatus, required this.startTime});
  final bool startTimeStatus;
  final DateTime startTime;

  @override
  State<TimeCounterBar> createState() => _TimeCounterBarState();
}

class _TimeCounterBarState extends State<TimeCounterBar> {
  Timer? _timer;
  String _formattedTime = '00:00:00';

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startTimeStatus) {
      _startTimer(widget.startTime);
    }
    return generalMeetingGeneralInfoCard(
        title: "Speech Time Counter",
        content:
            !widget.startTimeStatus ? "Has Not Started Yet" : _formattedTime);
  }

  void _startTimer(DateTime startTime) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _formattedTime = formatTime(DateTime.now().difference(startTime));
      });
    });
  }
}
