import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/router_paths.dart';
import 'package:speaxpoint/views/home_screen.dart';

Route<dynamic>? createRoute(settings) {
  switch (settings.name) {
    case RouterPaths.root:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
  return null;
}
