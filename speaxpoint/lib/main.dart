import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:speaxpoint/views/home_screen.dart';

import 'app/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();

  runApp(const HomeScreen());
}
