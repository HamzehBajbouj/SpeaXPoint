import 'package:flutter/material.dart';


class ManageRolePlayersScreen extends StatefulWidget {
  const ManageRolePlayersScreen({super.key});

  @override
  State<ManageRolePlayersScreen> createState() => _ManageRolePlayersScreenState();
}

class _ManageRolePlayersScreenState extends State<ManageRolePlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Manage Role Players Screen"),
      ),
    );
  }
}