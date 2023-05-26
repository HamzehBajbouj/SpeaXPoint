import 'package:flutter/material.dart';


class SpeakerObservedDataScreen extends StatefulWidget {
  const SpeakerObservedDataScreen({super.key});

  @override
  State<SpeakerObservedDataScreen> createState() =>
      _SpeakerObservedDataScreenState();
}

class _SpeakerObservedDataScreenState extends State<SpeakerObservedDataScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("speaker observed data screen"),
      ),
    );
  }
}
