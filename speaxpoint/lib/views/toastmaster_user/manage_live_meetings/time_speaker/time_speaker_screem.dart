import 'package:flutter/material.dart';


class TimeSpeakerScreen extends StatefulWidget {
  const TimeSpeakerScreen({super.key});

  @override
  State<TimeSpeakerScreen> createState() => _TimeSpeakerScreenState();
}

class _TimeSpeakerScreenState extends State<TimeSpeakerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Time Speaker Screen"),
      ),
    );
  }
}
