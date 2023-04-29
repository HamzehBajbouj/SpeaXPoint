// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i30;
import 'package:speaxpoint/views/club_president_user/club_member_management/club_members_management_screen.dart'
    as _i10;
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_from_set_up.dart'
    as _i9;
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_screen.dart'
    as _i16;
import 'package:speaxpoint/views/club_president_user/club_president_home_screen.dart'
    as _i11;
import 'package:speaxpoint/views/club_president_user/dashboard/president_dashboard_screen.dart'
    as _i15;
import 'package:speaxpoint/views/club_president_user/profile_management/club_profile_managment_screen.dart'
    as _i8;
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/allocate_role_players_screen.dart'
    as _i22;
import 'package:speaxpoint/views/toastmaster_user/ask_for_volunteers/ask_for_volunteers_screen.dart'
    as _i23;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/announce_chapter_meeting_screen.dart'
    as _i25;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/chapter_meeting_announcement_view_screen.dart'
    as _i26;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/manage_chapter_meeting_announcement_screen.dart'
    as _i24;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/volunteer_announcement_view_details_screen.dart'
    as _i28;
import 'package:speaxpoint/views/toastmaster_user/dashboard/toastmaster_dashboard_screen.dart'
    as _i19;
import 'package:speaxpoint/views/toastmaster_user/manage_coming_meetings/manage_coming_sessions_screen.dart'
    as _i20;
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/prepare_meeting_agenda_screen.dart'
    as _i21;
import 'package:speaxpoint/views/toastmaster_user/profile_management/toastmaster_profile_management_screen.dart'
    as _i18;
import 'package:speaxpoint/views/toastmaster_user/scheduled_meetings/toastmaster_scheduled_meetings_screen.dart'
    as _i17;
import 'package:speaxpoint/views/toastmaster_user/search_chapter_meetings/search_chapter_meeting_screen.dart'
    as _i27;
import 'package:speaxpoint/views/toastmaster_user/toastmaster_home_screen.dart'
    as _i12;
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_registration_screen.dart'
    as _i5;
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_setup_registrationScreen.dart'
    as _i7;
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_username_registration_screen.dart'
    as _i6;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_as_toastmaster_screen.dart'
    as _i3;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_club_president/log_in_club_president_screen.dart'
    as _i2;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/guest_favorite_name_screen.dart'
    as _i14;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/log_in_as_guest_screen.dart'
    as _i13;
import 'package:speaxpoint/views/user_authentication/log_in_screens/user_type_selection_screen.dart'
    as _i1;

class AppRouter extends _i29.RootStackRouter {
  AppRouter([_i30.GlobalKey<_i30.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i29.PageFactory> pagesMap = {
    UserTypeSelectionRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.UserTypeSelectionScreen(),
      );
    },
    ClubPresidentLoginRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.LogInAsClubPresidentScreen(),
      );
    },
    ToastmasterLoginRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.LogInAsToastmasterScreen(),
      );
    },
    EmptyRouterPageRoute.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubRegistrationRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.ClubRegistrationScreen(),
      );
    },
    ClubUsernameRegistrationRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.ClubUsernameRegistrationScreen(),
      );
    },
    ClubSetUpRegistrationRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.ClubSetUpRegistrationScreen(),
      );
    },
    ClubProfileManagementSetUpRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.ClubProfileManagementScreen(),
      );
    },
    SetAndManageMemberAccountRouter.name: (routeData) {
      final args = routeData.argsAs<SetAndManageMemberAccountRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.ManageMemeberAccountFromSetUpScreen(
          key: args.key,
          isInEditMode: args.isInEditMode,
        ),
      );
    },
    ClubMembersManagementSetUpRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ClubMembersManagementSetUpRouterArgs>(
          orElse: () => ClubMembersManagementSetUpRouterArgs(
              fromSetUpRouter: pathParams.getBool('fromSetUp')));
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i10.ClubMembersManagementScreen(
          key: args.key,
          fromSetUpRouter: args.fromSetUpRouter,
        ),
      );
    },
    ClubPresidentHomeRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.ClubPresidentHomeScreen(),
      );
    },
    ToastmasterHomeRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.ToastmasterHomeScreen(),
      );
    },
    GuestLoginRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.LogInAsGuestScreen(),
      );
    },
    GuestFavoriteNameRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GuestFavoriteNameRouterArgs>(
          orElse: () => GuestFavoriteNameRouterArgs(
              guestHasRole: pathParams.getBool('guestHasRole')));
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i14.GuestFavoriteNameScreen(
          key: args.key,
          guestHasRole: args.guestHasRole,
        ),
      );
    },
    ClubPresidentDashboardRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubProfileManagementRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.ClubProfileManagementScreen(),
      );
    },
    PresidentDashboardScreenRoute.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i15.PresidentDashboardScreen(),
      );
    },
    ClubMembersManagementRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ClubMembersManagementRouterArgs>(
          orElse: () => ClubMembersManagementRouterArgs(
              fromSetUpRouter: pathParams.getBool('fromSetUp')));
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i10.ClubMembersManagementScreen(
          key: args.key,
          fromSetUpRouter: args.fromSetUpRouter,
        ),
      );
    },
    ManageAccountRouter.name: (routeData) {
      final args = routeData.argsAs<ManageAccountRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i16.ManageMemberAccountScreen(
          key: args.key,
          isInEditMode: args.isInEditMode,
          isTheUserPresidentl: args.isTheUserPresidentl,
          userId: args.userId,
        ),
      );
    },
    ToastmasterDashboardRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ToastmasterScheduledMeetingsRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i17.ToastmasterScheduledMeetingsScreen(),
      );
    },
    ToastmasterProfileManagementRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i18.ToastmasterProfileManagementScreen(),
      );
    },
    ToastmasterDashboardScreenRoute.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i19.ToastmasterDashboardScreen(),
      );
    },
    ManageComingSessionsRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i20.ManageComingSessionsScreen(),
      );
    },
    PrepareMeetingAgendaRouter.name: (routeData) {
      final args = routeData.argsAs<PrepareMeetingAgendaRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i21.PrepareMeetingAgendaScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
        ),
      );
    },
    AllocateRolePlayerRouter.name: (routeData) {
      final args = routeData.argsAs<AllocateRolePlayerRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i22.AllocateRolePlayerScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    AskForVolunteersRouter.name: (routeData) {
      final args = routeData.argsAs<AskForVolunteersRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i23.AskForVolunteersScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          viewMode: args.viewMode,
          clubId: args.clubId,
        ),
      );
    },
    ManageChapterMeetingAnnouncementsRouter.name: (routeData) {
      final args =
          routeData.argsAs<ManageChapterMeetingAnnouncementsRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i24.ManageChapterMeetingAnnouncementsScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    AnnounceChapterMeetingRouter.name: (routeData) {
      final args = routeData.argsAs<AnnounceChapterMeetingRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i25.AnnounceChapterMeetingScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    ChapterMeetingAnnouncementViewRouter.name: (routeData) {
      final args = routeData.argsAs<ChapterMeetingAnnouncementViewRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i26.ChapterMeetingAnnouncementViewScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          viewedFromSearchPage: args.viewedFromSearchPage,
          clubId: args.clubId,
        ),
      );
    },
    SearchChapterMeetingRouter.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i27.SearchChapterMeetingScreen(),
      );
    },
    VolunteerAnnouncementViewDetailsRouter.name: (routeData) {
      final args =
          routeData.argsAs<VolunteerAnnouncementViewDetailsRouterArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i28.VolunteerAnnouncementViewDetailsScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
  };

  @override
  List<_i29.RouteConfig> get routes => [
        _i29.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/userType',
          fullMatch: true,
        ),
        _i29.RouteConfig(
          UserTypeSelectionRouter.name,
          path: '/userType',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: UserTypeSelectionRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          ClubPresidentLoginRouter.name,
          path: '/presidentLogin',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubPresidentLoginRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          ToastmasterLoginRouter.name,
          path: '/toastmasterLogin',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ToastmasterLoginRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          EmptyRouterPageRoute.name,
          path: '/guestLogin',
          children: [
            _i29.RouteConfig(
              GuestLoginRouter.name,
              path: '',
              parent: EmptyRouterPageRoute.name,
            ),
            _i29.RouteConfig(
              GuestFavoriteNameRouter.name,
              path: 'favoriteName/:guestHasRole',
              parent: EmptyRouterPageRoute.name,
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: EmptyRouterPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          ClubRegistrationRouter.name,
          path: '/clubRegistration',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubRegistrationRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          ClubUsernameRegistrationRouter.name,
          path: '/clubUsernameRegistration',
        ),
        _i29.RouteConfig(
          ClubSetUpRegistrationRouter.name,
          path: '/clubSetUp',
        ),
        _i29.RouteConfig(
          ClubProfileManagementSetUpRouter.name,
          path: '/clubProfileManagggement',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubProfileManagementSetUpRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          SetAndManageMemberAccountRouter.name,
          path: '/setAndManageMemberAccount',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SetAndManageMemberAccountRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          ClubMembersManagementSetUpRouter.name,
          path: '/clubMembersManagementSetUp/:fromSetUp',
          children: [
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubMembersManagementSetUpRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i29.RouteConfig(
          ClubPresidentHomeRouter.name,
          path: '/clubPresidentHomeScreen',
          children: [
            _i29.RouteConfig(
              ClubPresidentDashboardRouter.name,
              path: 'clubPresidentDashboard',
              parent: ClubPresidentHomeRouter.name,
              children: [
                _i29.RouteConfig(
                  PresidentDashboardScreenRoute.name,
                  path: '',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i29.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: PresidentDashboardScreenRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
                _i29.RouteConfig(
                  ClubMembersManagementRouter.name,
                  path: 'clubMembersManagement/:fromSetUp',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i29.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ClubMembersManagementRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
                _i29.RouteConfig(
                  ManageAccountRouter.name,
                  path: 'manageMemberAccount',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i29.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ManageAccountRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
              ],
            ),
            _i29.RouteConfig(
              ClubProfileManagementRouter.name,
              path: 'clubProfileManagement',
              parent: ClubPresidentHomeRouter.name,
            ),
          ],
        ),
        _i29.RouteConfig(
          ToastmasterHomeRouter.name,
          path: '/toastmasterHomeScreen',
          children: [
            _i29.RouteConfig(
              ToastmasterDashboardRouter.name,
              path: 'toastmasterDashboard',
              parent: ToastmasterHomeRouter.name,
              children: [
                _i29.RouteConfig(
                  ToastmasterDashboardScreenRoute.name,
                  path: '',
                  parent: ToastmasterDashboardRouter.name,
                  children: [
                    _i29.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ToastmasterDashboardScreenRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
                _i29.RouteConfig(
                  ManageComingSessionsRouter.name,
                  path: 'manageComingSessions',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  PrepareMeetingAgendaRouter.name,
                  path: 'prepareMeetingAgenda',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  AllocateRolePlayerRouter.name,
                  path: 'allocateRolePlayer',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  AskForVolunteersRouter.name,
                  path: 'askForVolunteers',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  ManageChapterMeetingAnnouncementsRouter.name,
                  path: 'manageChapterMeetingAnnouncements',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  AnnounceChapterMeetingRouter.name,
                  path: 'announceChapterMeeting',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  ChapterMeetingAnnouncementViewRouter.name,
                  path: 'chapterMeetingAnnouncementView',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  SearchChapterMeetingRouter.name,
                  path: 'searchChapterMeeting',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i29.RouteConfig(
                  VolunteerAnnouncementViewDetailsRouter.name,
                  path: 'volunteerAnnouncementViewDetails',
                  parent: ToastmasterDashboardRouter.name,
                ),
              ],
            ),
            _i29.RouteConfig(
              ToastmasterScheduledMeetingsRouter.name,
              path: 'scheduledMeetings',
              parent: ToastmasterHomeRouter.name,
            ),
            _i29.RouteConfig(
              ToastmasterProfileManagementRouter.name,
              path: 'toastmasterProfileManagement',
              parent: ToastmasterHomeRouter.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.UserTypeSelectionScreen]
class UserTypeSelectionRouter extends _i29.PageRouteInfo<void> {
  const UserTypeSelectionRouter({List<_i29.PageRouteInfo>? children})
      : super(
          UserTypeSelectionRouter.name,
          path: '/userType',
          initialChildren: children,
        );

  static const String name = 'UserTypeSelectionRouter';
}

/// generated route for
/// [_i2.LogInAsClubPresidentScreen]
class ClubPresidentLoginRouter extends _i29.PageRouteInfo<void> {
  const ClubPresidentLoginRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ClubPresidentLoginRouter.name,
          path: '/presidentLogin',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentLoginRouter';
}

/// generated route for
/// [_i3.LogInAsToastmasterScreen]
class ToastmasterLoginRouter extends _i29.PageRouteInfo<void> {
  const ToastmasterLoginRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ToastmasterLoginRouter.name,
          path: '/toastmasterLogin',
          initialChildren: children,
        );

  static const String name = 'ToastmasterLoginRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class EmptyRouterPageRoute extends _i29.PageRouteInfo<void> {
  const EmptyRouterPageRoute({List<_i29.PageRouteInfo>? children})
      : super(
          EmptyRouterPageRoute.name,
          path: '/guestLogin',
          initialChildren: children,
        );

  static const String name = 'EmptyRouterPageRoute';
}

/// generated route for
/// [_i5.ClubRegistrationScreen]
class ClubRegistrationRouter extends _i29.PageRouteInfo<void> {
  const ClubRegistrationRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ClubRegistrationRouter.name,
          path: '/clubRegistration',
          initialChildren: children,
        );

  static const String name = 'ClubRegistrationRouter';
}

/// generated route for
/// [_i6.ClubUsernameRegistrationScreen]
class ClubUsernameRegistrationRouter extends _i29.PageRouteInfo<void> {
  const ClubUsernameRegistrationRouter()
      : super(
          ClubUsernameRegistrationRouter.name,
          path: '/clubUsernameRegistration',
        );

  static const String name = 'ClubUsernameRegistrationRouter';
}

/// generated route for
/// [_i7.ClubSetUpRegistrationScreen]
class ClubSetUpRegistrationRouter extends _i29.PageRouteInfo<void> {
  const ClubSetUpRegistrationRouter()
      : super(
          ClubSetUpRegistrationRouter.name,
          path: '/clubSetUp',
        );

  static const String name = 'ClubSetUpRegistrationRouter';
}

/// generated route for
/// [_i8.ClubProfileManagementScreen]
class ClubProfileManagementSetUpRouter extends _i29.PageRouteInfo<void> {
  const ClubProfileManagementSetUpRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ClubProfileManagementSetUpRouter.name,
          path: '/clubProfileManagggement',
          initialChildren: children,
        );

  static const String name = 'ClubProfileManagementSetUpRouter';
}

/// generated route for
/// [_i9.ManageMemeberAccountFromSetUpScreen]
class SetAndManageMemberAccountRouter
    extends _i29.PageRouteInfo<SetAndManageMemberAccountRouterArgs> {
  SetAndManageMemberAccountRouter({
    _i30.Key? key,
    required bool isInEditMode,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          SetAndManageMemberAccountRouter.name,
          path: '/setAndManageMemberAccount',
          args: SetAndManageMemberAccountRouterArgs(
            key: key,
            isInEditMode: isInEditMode,
          ),
          initialChildren: children,
        );

  static const String name = 'SetAndManageMemberAccountRouter';
}

class SetAndManageMemberAccountRouterArgs {
  const SetAndManageMemberAccountRouterArgs({
    this.key,
    required this.isInEditMode,
  });

  final _i30.Key? key;

  final bool isInEditMode;

  @override
  String toString() {
    return 'SetAndManageMemberAccountRouterArgs{key: $key, isInEditMode: $isInEditMode}';
  }
}

/// generated route for
/// [_i10.ClubMembersManagementScreen]
class ClubMembersManagementSetUpRouter
    extends _i29.PageRouteInfo<ClubMembersManagementSetUpRouterArgs> {
  ClubMembersManagementSetUpRouter({
    _i30.Key? key,
    required bool fromSetUpRouter,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          ClubMembersManagementSetUpRouter.name,
          path: '/clubMembersManagementSetUp/:fromSetUp',
          args: ClubMembersManagementSetUpRouterArgs(
            key: key,
            fromSetUpRouter: fromSetUpRouter,
          ),
          rawPathParams: {'fromSetUp': fromSetUpRouter},
          initialChildren: children,
        );

  static const String name = 'ClubMembersManagementSetUpRouter';
}

class ClubMembersManagementSetUpRouterArgs {
  const ClubMembersManagementSetUpRouterArgs({
    this.key,
    required this.fromSetUpRouter,
  });

  final _i30.Key? key;

  final bool fromSetUpRouter;

  @override
  String toString() {
    return 'ClubMembersManagementSetUpRouterArgs{key: $key, fromSetUpRouter: $fromSetUpRouter}';
  }
}

/// generated route for
/// [_i11.ClubPresidentHomeScreen]
class ClubPresidentHomeRouter extends _i29.PageRouteInfo<void> {
  const ClubPresidentHomeRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ClubPresidentHomeRouter.name,
          path: '/clubPresidentHomeScreen',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentHomeRouter';
}

/// generated route for
/// [_i12.ToastmasterHomeScreen]
class ToastmasterHomeRouter extends _i29.PageRouteInfo<void> {
  const ToastmasterHomeRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ToastmasterHomeRouter.name,
          path: '/toastmasterHomeScreen',
          initialChildren: children,
        );

  static const String name = 'ToastmasterHomeRouter';
}

/// generated route for
/// [_i13.LogInAsGuestScreen]
class GuestLoginRouter extends _i29.PageRouteInfo<void> {
  const GuestLoginRouter()
      : super(
          GuestLoginRouter.name,
          path: '',
        );

  static const String name = 'GuestLoginRouter';
}

/// generated route for
/// [_i14.GuestFavoriteNameScreen]
class GuestFavoriteNameRouter
    extends _i29.PageRouteInfo<GuestFavoriteNameRouterArgs> {
  GuestFavoriteNameRouter({
    _i30.Key? key,
    required bool guestHasRole,
  }) : super(
          GuestFavoriteNameRouter.name,
          path: 'favoriteName/:guestHasRole',
          args: GuestFavoriteNameRouterArgs(
            key: key,
            guestHasRole: guestHasRole,
          ),
          rawPathParams: {'guestHasRole': guestHasRole},
        );

  static const String name = 'GuestFavoriteNameRouter';
}

class GuestFavoriteNameRouterArgs {
  const GuestFavoriteNameRouterArgs({
    this.key,
    required this.guestHasRole,
  });

  final _i30.Key? key;

  final bool guestHasRole;

  @override
  String toString() {
    return 'GuestFavoriteNameRouterArgs{key: $key, guestHasRole: $guestHasRole}';
  }
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClubPresidentDashboardRouter extends _i29.PageRouteInfo<void> {
  const ClubPresidentDashboardRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ClubPresidentDashboardRouter.name,
          path: 'clubPresidentDashboard',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentDashboardRouter';
}

/// generated route for
/// [_i8.ClubProfileManagementScreen]
class ClubProfileManagementRouter extends _i29.PageRouteInfo<void> {
  const ClubProfileManagementRouter()
      : super(
          ClubProfileManagementRouter.name,
          path: 'clubProfileManagement',
        );

  static const String name = 'ClubProfileManagementRouter';
}

/// generated route for
/// [_i15.PresidentDashboardScreen]
class PresidentDashboardScreenRoute extends _i29.PageRouteInfo<void> {
  const PresidentDashboardScreenRoute({List<_i29.PageRouteInfo>? children})
      : super(
          PresidentDashboardScreenRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'PresidentDashboardScreenRoute';
}

/// generated route for
/// [_i10.ClubMembersManagementScreen]
class ClubMembersManagementRouter
    extends _i29.PageRouteInfo<ClubMembersManagementRouterArgs> {
  ClubMembersManagementRouter({
    _i30.Key? key,
    required bool fromSetUpRouter,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          ClubMembersManagementRouter.name,
          path: 'clubMembersManagement/:fromSetUp',
          args: ClubMembersManagementRouterArgs(
            key: key,
            fromSetUpRouter: fromSetUpRouter,
          ),
          rawPathParams: {'fromSetUp': fromSetUpRouter},
          initialChildren: children,
        );

  static const String name = 'ClubMembersManagementRouter';
}

class ClubMembersManagementRouterArgs {
  const ClubMembersManagementRouterArgs({
    this.key,
    required this.fromSetUpRouter,
  });

  final _i30.Key? key;

  final bool fromSetUpRouter;

  @override
  String toString() {
    return 'ClubMembersManagementRouterArgs{key: $key, fromSetUpRouter: $fromSetUpRouter}';
  }
}

/// generated route for
/// [_i16.ManageMemberAccountScreen]
class ManageAccountRouter extends _i29.PageRouteInfo<ManageAccountRouterArgs> {
  ManageAccountRouter({
    _i30.Key? key,
    required bool isInEditMode,
    required bool isTheUserPresidentl,
    String? userId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          ManageAccountRouter.name,
          path: 'manageMemberAccount',
          args: ManageAccountRouterArgs(
            key: key,
            isInEditMode: isInEditMode,
            isTheUserPresidentl: isTheUserPresidentl,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'ManageAccountRouter';
}

class ManageAccountRouterArgs {
  const ManageAccountRouterArgs({
    this.key,
    required this.isInEditMode,
    required this.isTheUserPresidentl,
    this.userId,
  });

  final _i30.Key? key;

  final bool isInEditMode;

  final bool isTheUserPresidentl;

  final String? userId;

  @override
  String toString() {
    return 'ManageAccountRouterArgs{key: $key, isInEditMode: $isInEditMode, isTheUserPresidentl: $isTheUserPresidentl, userId: $userId}';
  }
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ToastmasterDashboardRouter extends _i29.PageRouteInfo<void> {
  const ToastmasterDashboardRouter({List<_i29.PageRouteInfo>? children})
      : super(
          ToastmasterDashboardRouter.name,
          path: 'toastmasterDashboard',
          initialChildren: children,
        );

  static const String name = 'ToastmasterDashboardRouter';
}

/// generated route for
/// [_i17.ToastmasterScheduledMeetingsScreen]
class ToastmasterScheduledMeetingsRouter extends _i29.PageRouteInfo<void> {
  const ToastmasterScheduledMeetingsRouter()
      : super(
          ToastmasterScheduledMeetingsRouter.name,
          path: 'scheduledMeetings',
        );

  static const String name = 'ToastmasterScheduledMeetingsRouter';
}

/// generated route for
/// [_i18.ToastmasterProfileManagementScreen]
class ToastmasterProfileManagementRouter extends _i29.PageRouteInfo<void> {
  const ToastmasterProfileManagementRouter()
      : super(
          ToastmasterProfileManagementRouter.name,
          path: 'toastmasterProfileManagement',
        );

  static const String name = 'ToastmasterProfileManagementRouter';
}

/// generated route for
/// [_i19.ToastmasterDashboardScreen]
class ToastmasterDashboardScreenRoute extends _i29.PageRouteInfo<void> {
  const ToastmasterDashboardScreenRoute({List<_i29.PageRouteInfo>? children})
      : super(
          ToastmasterDashboardScreenRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'ToastmasterDashboardScreenRoute';
}

/// generated route for
/// [_i20.ManageComingSessionsScreen]
class ManageComingSessionsRouter extends _i29.PageRouteInfo<void> {
  const ManageComingSessionsRouter()
      : super(
          ManageComingSessionsRouter.name,
          path: 'manageComingSessions',
        );

  static const String name = 'ManageComingSessionsRouter';
}

/// generated route for
/// [_i21.PrepareMeetingAgendaScreen]
class PrepareMeetingAgendaRouter
    extends _i29.PageRouteInfo<PrepareMeetingAgendaRouterArgs> {
  PrepareMeetingAgendaRouter({
    _i30.Key? key,
    required String chapterMeetingId,
  }) : super(
          PrepareMeetingAgendaRouter.name,
          path: 'prepareMeetingAgenda',
          args: PrepareMeetingAgendaRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
          ),
        );

  static const String name = 'PrepareMeetingAgendaRouter';
}

class PrepareMeetingAgendaRouterArgs {
  const PrepareMeetingAgendaRouterArgs({
    this.key,
    required this.chapterMeetingId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  @override
  String toString() {
    return 'PrepareMeetingAgendaRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId}';
  }
}

/// generated route for
/// [_i22.AllocateRolePlayerScreen]
class AllocateRolePlayerRouter
    extends _i29.PageRouteInfo<AllocateRolePlayerRouterArgs> {
  AllocateRolePlayerRouter({
    _i30.Key? key,
    required String chapterMeetingId,
    required String clubId,
  }) : super(
          AllocateRolePlayerRouter.name,
          path: 'allocateRolePlayer',
          args: AllocateRolePlayerRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
            clubId: clubId,
          ),
        );

  static const String name = 'AllocateRolePlayerRouter';
}

class AllocateRolePlayerRouterArgs {
  const AllocateRolePlayerRouterArgs({
    this.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'AllocateRolePlayerRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i23.AskForVolunteersScreen]
class AskForVolunteersRouter
    extends _i29.PageRouteInfo<AskForVolunteersRouterArgs> {
  AskForVolunteersRouter({
    _i30.Key? key,
    required String chapterMeetingId,
    required bool viewMode,
    required String clubId,
  }) : super(
          AskForVolunteersRouter.name,
          path: 'askForVolunteers',
          args: AskForVolunteersRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
            viewMode: viewMode,
            clubId: clubId,
          ),
        );

  static const String name = 'AskForVolunteersRouter';
}

class AskForVolunteersRouterArgs {
  const AskForVolunteersRouterArgs({
    this.key,
    required this.chapterMeetingId,
    required this.viewMode,
    required this.clubId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  final bool viewMode;

  final String clubId;

  @override
  String toString() {
    return 'AskForVolunteersRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, viewMode: $viewMode, clubId: $clubId}';
  }
}

/// generated route for
/// [_i24.ManageChapterMeetingAnnouncementsScreen]
class ManageChapterMeetingAnnouncementsRouter
    extends _i29.PageRouteInfo<ManageChapterMeetingAnnouncementsRouterArgs> {
  ManageChapterMeetingAnnouncementsRouter({
    _i30.Key? key,
    required String chapterMeetingId,
    required String clubId,
  }) : super(
          ManageChapterMeetingAnnouncementsRouter.name,
          path: 'manageChapterMeetingAnnouncements',
          args: ManageChapterMeetingAnnouncementsRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
            clubId: clubId,
          ),
        );

  static const String name = 'ManageChapterMeetingAnnouncementsRouter';
}

class ManageChapterMeetingAnnouncementsRouterArgs {
  const ManageChapterMeetingAnnouncementsRouterArgs({
    this.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'ManageChapterMeetingAnnouncementsRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i25.AnnounceChapterMeetingScreen]
class AnnounceChapterMeetingRouter
    extends _i29.PageRouteInfo<AnnounceChapterMeetingRouterArgs> {
  AnnounceChapterMeetingRouter({
    _i30.Key? key,
    required String chapterMeetingId,
    required String clubId,
  }) : super(
          AnnounceChapterMeetingRouter.name,
          path: 'announceChapterMeeting',
          args: AnnounceChapterMeetingRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
            clubId: clubId,
          ),
        );

  static const String name = 'AnnounceChapterMeetingRouter';
}

class AnnounceChapterMeetingRouterArgs {
  const AnnounceChapterMeetingRouterArgs({
    this.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'AnnounceChapterMeetingRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i26.ChapterMeetingAnnouncementViewScreen]
class ChapterMeetingAnnouncementViewRouter
    extends _i29.PageRouteInfo<ChapterMeetingAnnouncementViewRouterArgs> {
  ChapterMeetingAnnouncementViewRouter({
    _i30.Key? key,
    required String chapterMeetingId,
    required bool viewedFromSearchPage,
    required String clubId,
  }) : super(
          ChapterMeetingAnnouncementViewRouter.name,
          path: 'chapterMeetingAnnouncementView',
          args: ChapterMeetingAnnouncementViewRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
            viewedFromSearchPage: viewedFromSearchPage,
            clubId: clubId,
          ),
        );

  static const String name = 'ChapterMeetingAnnouncementViewRouter';
}

class ChapterMeetingAnnouncementViewRouterArgs {
  const ChapterMeetingAnnouncementViewRouterArgs({
    this.key,
    required this.chapterMeetingId,
    required this.viewedFromSearchPage,
    required this.clubId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  final bool viewedFromSearchPage;

  final String clubId;

  @override
  String toString() {
    return 'ChapterMeetingAnnouncementViewRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, viewedFromSearchPage: $viewedFromSearchPage, clubId: $clubId}';
  }
}

/// generated route for
/// [_i27.SearchChapterMeetingScreen]
class SearchChapterMeetingRouter extends _i29.PageRouteInfo<void> {
  const SearchChapterMeetingRouter()
      : super(
          SearchChapterMeetingRouter.name,
          path: 'searchChapterMeeting',
        );

  static const String name = 'SearchChapterMeetingRouter';
}

/// generated route for
/// [_i28.VolunteerAnnouncementViewDetailsScreen]
class VolunteerAnnouncementViewDetailsRouter
    extends _i29.PageRouteInfo<VolunteerAnnouncementViewDetailsRouterArgs> {
  VolunteerAnnouncementViewDetailsRouter({
    _i30.Key? key,
    required String chapterMeetingId,
    required String clubId,
  }) : super(
          VolunteerAnnouncementViewDetailsRouter.name,
          path: 'volunteerAnnouncementViewDetails',
          args: VolunteerAnnouncementViewDetailsRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
            clubId: clubId,
          ),
        );

  static const String name = 'VolunteerAnnouncementViewDetailsRouter';
}

class VolunteerAnnouncementViewDetailsRouterArgs {
  const VolunteerAnnouncementViewDetailsRouterArgs({
    this.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  final _i30.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'VolunteerAnnouncementViewDetailsRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}
