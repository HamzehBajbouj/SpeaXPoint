import 'package:flutter/material.dart';

class CountTimeFillersScreen extends StatefulWidget {
  const CountTimeFillersScreen({super.key});

  @override
  State<CountTimeFillersScreen> createState() => _CountTimeFillersScreenState();
}

class _CountTimeFillersScreenState extends State<CountTimeFillersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Count Time Fillers Screen"),
      ),
    );
  }
}
