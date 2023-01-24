import 'package:flutter/material.dart';
import 'package:speaxpoint/app/app_router.dart';
import 'package:speaxpoint/app/service_locator.dart';
import 'package:speaxpoint/util/constants/router_paths.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/view_models/authentication_view_models/club_registration_view_model.dart';
import 'package:speaxpoint/view_models/authentication_view_models/log_in_view_model.dart';

class SpeaxPointApp extends StatelessWidget {
  const SpeaxPointApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ClubRegistrationViewModel>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<LogInViewModel>()),
      ],
      child: const MaterialApp(
        onGenerateRoute: createRoute,
        initialRoute: RouterPaths.root,
        title: 'SpeaXPoint',
      ),
    );
  }
}
