import 'package:flutter/material.dart';
import 'package:speaxpoint/views/speax_point_app.dart';

import 'app/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();

  runApp(const SpeaxPointApp());
}
