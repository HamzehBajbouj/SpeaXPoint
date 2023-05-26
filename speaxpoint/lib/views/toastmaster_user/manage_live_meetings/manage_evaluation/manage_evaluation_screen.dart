import 'package:flutter/material.dart';

class ManageEvaluationScreen extends StatefulWidget {
  const ManageEvaluationScreen({super.key});

  @override
  State<ManageEvaluationScreen> createState() => _ManageEvaluationScreenState();
}

class _ManageEvaluationScreenState extends State<ManageEvaluationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Manage Evaluation Screen"),
      ),
    );
  }
}
