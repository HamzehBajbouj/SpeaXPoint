import 'package:flutter/material.dart';

class SessionWaitingScreen extends StatefulWidget {
  const SessionWaitingScreen({super.key});

  @override
  State<SessionWaitingScreen> createState() => _SessionWaitingScreenState();
}

class _SessionWaitingScreenState extends State<SessionWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Waiting screen"),),
    );
  }
}
