import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:auto_route/auto_route.dart';

class ManageMemberAccountScreen extends StatefulWidget {
  const ManageMemberAccountScreen({
    super.key,
    @PathParam("pageMode") required this.isInEditMode,
  });
  final bool isInEditMode;

  @override
  State<ManageMemberAccountScreen> createState() =>
      _ManageMemberAccountScreenState();
}

class _ManageMemberAccountScreenState extends State<ManageMemberAccountScreen> {
  @override
  Widget build(BuildContext context) {
    print("fdsfsdfsdds fromMadd" + context.watchTabsRouter.stack.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("this is from account and the mode is "),
      ),
    );
  }
}
