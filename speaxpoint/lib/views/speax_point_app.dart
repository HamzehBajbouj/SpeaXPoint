import 'package:flutter/material.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/app/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/view_models/authentication_view_models/club_registration_view_model.dart';
import 'package:speaxpoint/view_models/authentication_view_models/log_in_view_model.dart';

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
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: "SpeaXPoint",
      ),
    );
  }
}
