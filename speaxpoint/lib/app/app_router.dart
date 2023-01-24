import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/router_paths.dart';
import 'package:speaxpoint/views/club_registration_screens/club_final_setup_registration.dart';
import 'package:speaxpoint/views/club_registration_screens/club_registration.dart';
import 'package:speaxpoint/views/club_registration_screens/club_username_registration.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_club_president/log_in_club_president.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_guest/guest_favorite_name.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_guest/log_in_guest.dart';
import 'package:speaxpoint/views/log_in_screens/log_in_toastmaster.dart';
import 'package:speaxpoint/views/log_in_screens/user_type_selection_screen.dart';

Route<dynamic>? createRoute(settings) {
  switch (settings.name) {
    case RouterPaths.root:
    case RouterPaths.userTypeSelection:
      return MaterialPageRoute(
          settings: settings, builder: (context) => const UserTypeSelection());
    case RouterPaths.registrationProfileSetUp:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ClubSetUpRegistration());

    case RouterPaths.clubRegistration:
      return MaterialPageRoute(
          settings: settings, builder: (context) => const ClubRegistration());
    case RouterPaths.clubUsernameRegistration:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ClubUsernameRegistration());
    case RouterPaths.clubPresidentSignIn:
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LogInAsClubPresident());
    case RouterPaths.toastmasterSignIn:
      return MaterialPageRoute(
          settings: settings, builder: (context) => const LogInAsToastmaster());
    case RouterPaths.guestSignIn:
      return MaterialPageRoute(
          settings: settings, builder: (context) => const LogInAsGuest());
              case RouterPaths.guestFavoriteName:
      return MaterialPageRoute(
          settings: settings, builder: (context) =>  GuestFavoriteName(guestHasRole:settings.arguments));
  }

  return null;
}
