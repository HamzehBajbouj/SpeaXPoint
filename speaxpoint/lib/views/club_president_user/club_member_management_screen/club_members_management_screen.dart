import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';

class ClubMembersManagementScreen extends StatelessWidget {
  const ClubMembersManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(AppMainColors.backgroundAndContent),
      body: Center(
        child:  Text("member management"),
      ),
    );
  }
}
