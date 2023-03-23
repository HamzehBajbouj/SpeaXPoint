import 'package:flutter/material.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/app/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/view_models/authentication_vm/club_registration_view_model.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_members_management_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/manage_member_account_view_model.dart';

class SpeaxPointApp extends StatelessWidget {
  SpeaxPointApp({super.key});
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ClubRegistrationViewModel>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<LogInViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ManageMemberAccountViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ClubMembersManagementViewModel>()),
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: "SpeaXPoint",
      ),
    );
  }
}
