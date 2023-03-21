import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:speaxpoint/views/club_president_user/club_member_management/club_members_management_screen.dart';
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_screen.dart';
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_setup_registrationScreen.dart';
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_registration_screen.dart';
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_username_registration_screen.dart';
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_as_toastmaster_screen.dart';
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_club_president/log_in_club_president_screen.dart';
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/guest_favorite_name_screen.dart';
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/log_in_as_guest_screen.dart';
import 'package:speaxpoint/views/user_authentication/log_in_screens/user_type_selection_screen.dart';

import '../views/club_president_user/club_president_home_screen.dart';
import '../views/club_president_user/dashboard/president_dashboard_screen.dart';
import '../views/club_president_user/profile_management/club_profile_managment_screen.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: "/userType",
      page: UserTypeSelectionScreen,
      name: "UserTypeSelectionRouter",
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/presidentLogin",
      page: LogInAsClubPresidentScreen,
      name: "ClubPresidentLoginRouter",
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/toastmasterLogin",
      page: LogInAsToastmasterScreen,
      name: "ToastmasterLoginRouter",
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/guestLogin",
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: "", page: LogInAsGuestScreen, name: "GuestLoginRouter"),
        AutoRoute(
            path: "favoriteName/:guestHasRole",
            page: GuestFavoriteNameScreen,
            name: "GuestFavoriteNameRouter"),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),
    AutoRoute(
      path: "/clubRegistration",
      name: "ClubRegistrationRouter",
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: "",
          page: ClubRegistrationScreen,
        ),
        AutoRoute(
            path: "clubUsernameRegistration",
            page: ClubUsernameRegistrationScreen,
            name: "ClubUsernameRegistrationRouter"),
        AutoRoute(
          path: "clubSetUp",
          page: ClubSetUpRegistrationScreen,
          name: "ClubSetUpRegistrationRouter",
        ),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: "/clubProfileManagement",
      name: "ClubProfileManagementSetUpRouter",
      page: ClubProfileManagementScreen,
      children: [RedirectRoute(path: '*', redirectTo: '')],
    ),
    AutoRoute(
      path: "/clubMembersManagementSetUp/:fromSetUp",
      name: "ClubMembersManagementSetUpRouter",
      page: ClubMembersManagementScreen,
      children: [
        // AutoRoute(
        //   path: "",
        //   page: ClubMembersManagementScreen,
        // ),
        AutoRoute(
          path: "manageMemberSetUpAccount/:pageMode",
          name: "ManageMemberAccountSetUpRouter",
          page: ManageMemberAccountScreen,
        ),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),
    // AutoRoute(
    //   path: "/manageMemberSetUpAccount/:pageMode",
    //   name: "ManageMemberAccountSetUpRouter",
    //   page: ManageMemberAccountScreen,
    // ),
    clubPresidentNav
  ],
)
class $AppRouter {}

const clubPresidentNav = AutoRoute(
  path: "/clubPresidentHomeScreen",
  page: ClubPresidentHomeScreen,
  name: "ClubPresidentHomeRouter",
  children: [
    AutoRoute(
      path: 'clubPresidentDashboard',
      name: 'ClubPresidentDashboardRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: PresidentDashboardScreen,
          children: [RedirectRoute(path: '*', redirectTo: '')],
        ),
        AutoRoute(
          path: 'clubMembersManagement/:fromSetUp',
          name: "ClubMembersManagementRouter",
          page: ClubMembersManagementScreen,
          children: [RedirectRoute(path: '*', redirectTo: '')],
        ),
        AutoRoute(
          path: "manageMemberAccount/:pageMode",
          name: "ManageAccountRouter",
          page: ManageMemberAccountScreen,
          children: [RedirectRoute(path: '*', redirectTo: '')],
        ),
      ],
    ),
    AutoRoute(
      path: "clubProfileManagement",
      name: "ClubProfileManagementRouter",
      page: ClubProfileManagementScreen,
    ),
  ],
);
