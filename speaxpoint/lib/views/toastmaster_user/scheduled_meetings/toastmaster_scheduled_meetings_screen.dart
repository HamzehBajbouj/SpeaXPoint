import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ToastmasterScheduledMeetingsScreen extends StatefulWidget {
  const ToastmasterScheduledMeetingsScreen({super.key});

  @override
  State<ToastmasterScheduledMeetingsScreen> createState() => _ToastmasterScheduledMeetingsScreenState();
}

class _ToastmasterScheduledMeetingsScreenState extends State<ToastmasterScheduledMeetingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("This is the scheduled meeting page")),
    );
  }
}