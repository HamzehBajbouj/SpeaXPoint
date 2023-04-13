import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AskForVolunteersScreen extends StatefulWidget {
  const AskForVolunteersScreen({super.key});

  @override
  State<AskForVolunteersScreen> createState() => _AskForVolunteersScreenState();
}

class _AskForVolunteersScreenState extends State<AskForVolunteersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Volunteers Screen"),
      ),
    );
  }
}
