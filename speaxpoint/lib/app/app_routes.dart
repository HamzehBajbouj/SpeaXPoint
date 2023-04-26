import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:speaxpoint/views/club_president_user/club_member_management/club_members_management_screen.dart';
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_screen.dart';
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_from_set_up.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/allocate_role_players_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/announce_chapter_meeting_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/chapter_meeting_announcement_view_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/manage_chapter_meeting_announcement_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/ask_for_volunteers/ask_for_volunteers_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/dashboard/toastmaster_dashboard_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/manage_coming_meetings/manage_coming_sessions_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/prepare_meeting_agenda_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/profile_management/toastmaster_profile_management_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/scheduled_meetings/toastmaster_scheduled_meetings_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/search_chapter_meetings/search_chapter_meeting_screen.dart';
import 'package:speaxpoint/views/toastmaster_user/toastmaster_home_screen.dart';
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
      page: ClubRegistrationScreen,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
        path: "/clubUsernameRegistration",
        page: ClubUsernameRegistrationScreen,
        name: "ClubUsernameRegistrationRouter"),
    AutoRoute(
      path: "/clubSetUp",
      page: ClubSetUpRegistrationScreen,
      name: "ClubSetUpRegistrationRouter",
    ),
    AutoRoute(
      path: "/clubProfileManagggement",
      name: "ClubProfileManagementSetUpRouter",
      page: ClubProfileManagementScreen,
      children: [RedirectRoute(path: '*', redirectTo: '')],
    ),
    AutoRoute(
      path: "/setAndManageMemberAccount",
      name: "SetAndManageMemberAccountRouter",
      page: ManageMemeberAccountFromSetUpScreen,
      children: [RedirectRoute(path: '*', redirectTo: '')],
    ),
    AutoRoute(
      path: "/clubMembersManagementSetUp/:fromSetUp",
      name: "ClubMembersManagementSetUpRouter",
      page: ClubMembersManagementScreen,
      children: [RedirectRoute(path: '*', redirectTo: '')],
    ),
    clubPresidentNav,
    toastMasterNav,
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
          path: "manageMemberAccount",
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

const toastMasterNav = AutoRoute(
  path: "/toastmasterHomeScreen",
  name: "ToastmasterHomeRouter",
  page: ToastmasterHomeScreen,
  children: [
    AutoRoute(
      path: "toastmasterDashboard",
      name: "ToastmasterDashboardRouter",
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: ToastmasterDashboardScreen,
          children: [
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: "manageComingSessions",
          name: "ManageComingSessionsRouter",
          page: ManageComingSessionsScreen,
        ),
        AutoRoute(
          path: "prepareMeetingAgenda",
          name: "PrepareMeetingAgendaRouter",
          page: PrepareMeetingAgendaScreen,
        ),
        AutoRoute(
          path: "allocateRolePlayer",
          name: "AllocateRolePlayerRouter",
          page: AllocateRolePlayerScreen,
        ),
        AutoRoute(
          path: "askForVolunteers",
          name: "AskForVolunteersRouter",
          page: AskForVolunteersScreen,
        ),
        AutoRoute(
          path: "manageChapterMeetingAnnouncements",
          name: "ManageChapterMeetingAnnouncementsRouter",
          page: ManageChapterMeetingAnnouncementsScreen,
        ),
        AutoRoute(
          path: "announceChapterMeeting",
          name: "AnnounceChapterMeetingRouter",
          page: AnnounceChapterMeetingScreen,
        ),
        AutoRoute(
          path: "chapterMeetingAnnouncementView",
          name: "ChapterMeetingAnnouncementViewRouter",
          page: ChapterMeetingAnnouncementViewScreen,
        ),
        AutoRoute(
          path: "searchChapterMeeting",
          name: "SearchChapterMeetingRouter",
          page: SearchChapterMeetingScreen,
        ),
      ],
    ),
    AutoRoute(
      path: "scheduledMeetings",
      name: "ToastmasterScheduledMeetingsRouter",
      page: ToastmasterScheduledMeetingsScreen,
    ),
    AutoRoute(
      path: "toastmasterProfileManagement",
      name: "ToastmasterProfileManagementRouter",
      page: ToastmasterProfileManagementScreen,
    ),
  ],
);
