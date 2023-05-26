import 'package:flutter/material.dart';

class ManageRolePlayersView extends StatefulWidget {
  final String chapterMeetingId;
  const ManageRolePlayersView({
    super.key,
    required this.chapterMeetingId,
  });

  @override
  State<ManageRolePlayersView> createState() =>
      _ManageRolePlayersViewState();
}

class _ManageRolePlayersViewState extends State<ManageRolePlayersView> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 15),
      child: Center(
        child: Text("Manage Role Players Screen"),
      ),
    );
  }
}
