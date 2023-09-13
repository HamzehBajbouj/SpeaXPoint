import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:auto_route/auto_route.dart';

class ManageMemeberAccountFromSetUpScreen extends StatefulWidget {
  const ManageMemeberAccountFromSetUpScreen({
    super.key,
    required this.isInEditMode
  });
  final bool isInEditMode;

  @override
  State<ManageMemeberAccountFromSetUpScreen> createState() => _ManageMemberAccountScreenState();
}

class _ManageMemberAccountScreenState extends State<ManageMemeberAccountFromSetUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("this is from account and the mode is "),
      ),
    );
  }
}
