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
import 'package:auto_route/auto_route.dart' as _i32;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i33;
import 'package:speaxpoint/views/club_president_user/club_member_management/club_members_management_screen.dart'
    as _i10;
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_from_set_up.dart'
    as _i9;
import 'package:speaxpoint/views/club_president_user/club_member_management/manage_member_account_screen.dart'
    as _i18;
import 'package:speaxpoint/views/club_president_user/club_president_home_screen.dart'
    as _i11;
import 'package:speaxpoint/views/club_president_user/dashboard/president_dashboard_screen.dart'
    as _i17;
import 'package:speaxpoint/views/club_president_user/profile_management/club_profile_managment_screen.dart'
    as _i8;
import 'package:speaxpoint/views/club_president_user/profile_management/edit_club_profile_details_screen.dart'
    as _i14;
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/allocate_role_players_screen.dart'
    as _i23;
import 'package:speaxpoint/views/toastmaster_user/ask_for_volunteers/ask_for_volunteers_screen.dart'
    as _i24;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/announce_chapter_meeting_screen.dart'
    as _i26;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/chapter_meeting_announcement_view_screen.dart'
    as _i27;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/manage_chapter_meeting_announcement_screen.dart'
    as _i25;
import 'package:speaxpoint/views/toastmaster_user/chapter_meeting_announcements/volunteer_announcement_view_details_screen.dart'
    as _i29;
import 'package:speaxpoint/views/toastmaster_user/dashboard/toastmaster_dashboard_screen.dart'
    as _i20;
import 'package:speaxpoint/views/toastmaster_user/manage_coming_meetings/manage_coming_sessions_screen.dart'
    as _i21;
import 'package:speaxpoint/views/toastmaster_user/prepare_meeting_agenda/prepare_meeting_agenda_screen.dart'
    as _i22;
import 'package:speaxpoint/views/toastmaster_user/profile_management/toastmaster_profile_management_screen.dart'
    as _i19;
import 'package:speaxpoint/views/toastmaster_user/scheduled_meetings/toastmaster_scheduled_meetings_screen.dart'
    as _i30;
import 'package:speaxpoint/views/toastmaster_user/scheduled_meetings/view_scheduled_meeting_details_screen.dart'
    as _i31;
import 'package:speaxpoint/views/toastmaster_user/search_chapter_meetings/search_chapter_meeting_screen.dart'
    as _i28;
import 'package:speaxpoint/views/toastmaster_user/session_redirection/session_redirection_screen.dart'
    as _i13;
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
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/guest_role_invitation_code_screen.dart'
    as _i16;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/log_in_as_guest_screen.dart'
    as _i15;
import 'package:speaxpoint/views/user_authentication/log_in_screens/user_type_selection_screen.dart'
    as _i1;

class AppRouter extends _i32.RootStackRouter {
  AppRouter([_i33.GlobalKey<_i33.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i32.PageFactory> pagesMap = {
    UserTypeSelectionRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.UserTypeSelectionScreen(),
      );
    },
    ClubPresidentLoginRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.LogInAsClubPresidentScreen(),
      );
    },
    ToastmasterLoginRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.LogInAsToastmasterScreen(),
      );
    },
    EmptyRouterPageRoute.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubRegistrationRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.ClubRegistrationScreen(),
      );
    },
    ClubUsernameRegistrationRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.ClubUsernameRegistrationScreen(),
      );
    },
    ClubSetUpRegistrationRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.ClubSetUpRegistrationScreen(),
      );
    },
    ClubProfileAnnouncementViewRouter.name: (routeData) {
      final args = routeData.argsAs<ClubProfileAnnouncementViewRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.ClubProfileManagementScreen(
          key: args.key,
          forViewOnly: args.forViewOnly,
          fromAnnouncementPage: args.fromAnnouncementPage,
          clubId: args.clubId,
        ),
      );
    },
    SetAndManageMemberAccountRouter.name: (routeData) {
      final args = routeData.argsAs<SetAndManageMemberAccountRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
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
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i10.ClubMembersManagementScreen(
          key: args.key,
          fromSetUpRouter: args.fromSetUpRouter,
        ),
      );
    },
    ClubPresidentHomeRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.ClubPresidentHomeScreen(),
      );
    },
    ToastmasterHomeRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.ToastmasterHomeScreen(),
      );
    },
    SessionRedirectionRouter.name: (routeData) {
      final args = routeData.argsAs<SessionRedirectionRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i13.SessionRedirectionScreen(
          key: args.key,
          isAGuest: args.isAGuest,
          chapterMeetingId: args.chapterMeetingId,
          chapterMeetingInvitationCode: args.chapterMeetingInvitationCode,
          guestHasRole: args.guestHasRole,
          guestInvitationCode: args.guestInvitationCode,
          toastmasterId: args.toastmasterId,
        ),
      );
    },
    EditClubProfileRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i14.EditClubProfileDetailsScreen(),
      );
    },
    GuestLoginRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i15.LogInAsGuestScreen(),
      );
    },
    GuestRoleInvitationCodeRouter.name: (routeData) {
      final args = routeData.argsAs<GuestRoleInvitationCodeRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i16.GuestRoleInvitationCodeScreen(
          key: args.key,
          chapterMeetingInvitationCode: args.chapterMeetingInvitationCode,
        ),
      );
    },
    ClubPresidentDashboardRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubProfileManagementRouter.name: (routeData) {
      final args = routeData.argsAs<ClubProfileManagementRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.ClubProfileManagementScreen(
          key: args.key,
          forViewOnly: args.forViewOnly,
          fromAnnouncementPage: args.fromAnnouncementPage,
          clubId: args.clubId,
        ),
      );
    },
    PresidentDashboardScreenRoute.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i17.PresidentDashboardScreen(),
      );
    },
    ClubMembersManagementRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ClubMembersManagementRouterArgs>(
          orElse: () => ClubMembersManagementRouterArgs(
              fromSetUpRouter: pathParams.getBool('fromSetUp')));
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i10.ClubMembersManagementScreen(
          key: args.key,
          fromSetUpRouter: args.fromSetUpRouter,
        ),
      );
    },
    ManageAccountRouter.name: (routeData) {
      final args = routeData.argsAs<ManageAccountRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i18.ManageMemberAccountScreen(
          key: args.key,
          isInEditMode: args.isInEditMode,
          isTheUserPresidentl: args.isTheUserPresidentl,
          userId: args.userId,
        ),
      );
    },
    ToastmasterDashboardRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ToastmasterScheduledMeetingsRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ToastmasterProfileManagementRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i19.ToastmasterProfileManagementScreen(),
      );
    },
    ToastmasterDashboardScreenRoute.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i20.ToastmasterDashboardScreen(),
      );
    },
    ManageComingSessionsRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i21.ManageComingSessionsScreen(),
      );
    },
    PrepareMeetingAgendaRouter.name: (routeData) {
      final args = routeData.argsAs<PrepareMeetingAgendaRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i22.PrepareMeetingAgendaScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
        ),
      );
    },
    AllocateRolePlayerRouter.name: (routeData) {
      final args = routeData.argsAs<AllocateRolePlayerRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i23.AllocateRolePlayerScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    AskForVolunteersRouter.name: (routeData) {
      final args = routeData.argsAs<AskForVolunteersRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i24.AskForVolunteersScreen(
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
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i25.ManageChapterMeetingAnnouncementsScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    AnnounceChapterMeetingRouter.name: (routeData) {
      final args = routeData.argsAs<AnnounceChapterMeetingRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i26.AnnounceChapterMeetingScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    ChapterMeetingAnnouncementViewRouter.name: (routeData) {
      final args = routeData.argsAs<ChapterMeetingAnnouncementViewRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i27.ChapterMeetingAnnouncementViewScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          viewedFromSearchPage: args.viewedFromSearchPage,
          clubId: args.clubId,
        ),
      );
    },
    SearchChapterMeetingRouter.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i28.SearchChapterMeetingScreen(),
      );
    },
    VolunteerAnnouncementViewDetailsRouter.name: (routeData) {
      final args =
          routeData.argsAs<VolunteerAnnouncementViewDetailsRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i29.VolunteerAnnouncementViewDetailsScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
          clubId: args.clubId,
        ),
      );
    },
    ToastmasterScheduledMeetingsScreenRoute.name: (routeData) {
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i30.ToastmasterScheduledMeetingsScreen(),
      );
    },
    ViewScheduledMeetingDetailsRouter.name: (routeData) {
      final args = routeData.argsAs<ViewScheduledMeetingDetailsRouterArgs>();
      return _i32.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i31.ViewScheduledMeetingDetailsScreen(
          key: args.key,
          chapterMeetingId: args.chapterMeetingId,
        ),
      );
    },
  };

  @override
  List<_i32.RouteConfig> get routes => [
        _i32.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/userType',
          fullMatch: true,
        ),
        _i32.RouteConfig(
          UserTypeSelectionRouter.name,
          path: '/userType',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: UserTypeSelectionRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          ClubPresidentLoginRouter.name,
          path: '/presidentLogin',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubPresidentLoginRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          ToastmasterLoginRouter.name,
          path: '/toastmasterLogin',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ToastmasterLoginRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          EmptyRouterPageRoute.name,
          path: '/guestLogin',
          children: [
            _i32.RouteConfig(
              GuestLoginRouter.name,
              path: '',
              parent: EmptyRouterPageRoute.name,
            ),
            _i32.RouteConfig(
              GuestRoleInvitationCodeRouter.name,
              path: 'guestRoleInvitationCode',
              parent: EmptyRouterPageRoute.name,
            ),
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: EmptyRouterPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i32.RouteConfig(
          ClubRegistrationRouter.name,
          path: '/clubRegistration',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubRegistrationRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          ClubUsernameRegistrationRouter.name,
          path: '/clubUsernameRegistration',
        ),
        _i32.RouteConfig(
          ClubSetUpRegistrationRouter.name,
          path: '/clubSetUp',
        ),
        _i32.RouteConfig(
          ClubProfileAnnouncementViewRouter.name,
          path: '/clubProfileAnnouncementView',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubProfileAnnouncementViewRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          SetAndManageMemberAccountRouter.name,
          path: '/setAndManageMemberAccount',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SetAndManageMemberAccountRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          ClubMembersManagementSetUpRouter.name,
          path: '/clubMembersManagementSetUp/:fromSetUp',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubMembersManagementSetUpRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          ClubPresidentHomeRouter.name,
          path: '/clubPresidentHomeScreen',
          children: [
            _i32.RouteConfig(
              ClubPresidentDashboardRouter.name,
              path: 'clubPresidentDashboard',
              parent: ClubPresidentHomeRouter.name,
              children: [
                _i32.RouteConfig(
                  PresidentDashboardScreenRoute.name,
                  path: '',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i32.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: PresidentDashboardScreenRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
                _i32.RouteConfig(
                  ClubMembersManagementRouter.name,
                  path: 'clubMembersManagement/:fromSetUp',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i32.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ClubMembersManagementRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
                _i32.RouteConfig(
                  ManageAccountRouter.name,
                  path: 'manageMemberAccount',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i32.RouteConfig(
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
            _i32.RouteConfig(
              ClubProfileManagementRouter.name,
              path: 'clubProfileManagement',
              parent: ClubPresidentHomeRouter.name,
            ),
          ],
        ),
        _i32.RouteConfig(
          ToastmasterHomeRouter.name,
          path: '/toastmasterHomeScreen',
          children: [
            _i32.RouteConfig(
              ToastmasterDashboardRouter.name,
              path: 'toastmasterDashboard',
              parent: ToastmasterHomeRouter.name,
              children: [
                _i32.RouteConfig(
                  ToastmasterDashboardScreenRoute.name,
                  path: '',
                  parent: ToastmasterDashboardRouter.name,
                  children: [
                    _i32.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ToastmasterDashboardScreenRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    )
                  ],
                ),
                _i32.RouteConfig(
                  ManageComingSessionsRouter.name,
                  path: 'manageComingSessions',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  PrepareMeetingAgendaRouter.name,
                  path: 'prepareMeetingAgenda',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  AllocateRolePlayerRouter.name,
                  path: 'allocateRolePlayer',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  AskForVolunteersRouter.name,
                  path: 'askForVolunteers',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  ManageChapterMeetingAnnouncementsRouter.name,
                  path: 'manageChapterMeetingAnnouncements',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  AnnounceChapterMeetingRouter.name,
                  path: 'announceChapterMeeting',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  ChapterMeetingAnnouncementViewRouter.name,
                  path: 'chapterMeetingAnnouncementView',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  SearchChapterMeetingRouter.name,
                  path: 'searchChapterMeeting',
                  parent: ToastmasterDashboardRouter.name,
                ),
                _i32.RouteConfig(
                  VolunteerAnnouncementViewDetailsRouter.name,
                  path: 'volunteerAnnouncementViewDetails',
                  parent: ToastmasterDashboardRouter.name,
                ),
              ],
            ),
            _i32.RouteConfig(
              ToastmasterScheduledMeetingsRouter.name,
              path: 'scheduledMeetings',
              parent: ToastmasterHomeRouter.name,
              children: [
                _i32.RouteConfig(
                  ToastmasterScheduledMeetingsScreenRoute.name,
                  path: '',
                  parent: ToastmasterScheduledMeetingsRouter.name,
                ),
                _i32.RouteConfig(
                  ViewScheduledMeetingDetailsRouter.name,
                  path: 'viewScheduledMeetingDetails',
                  parent: ToastmasterScheduledMeetingsRouter.name,
                ),
              ],
            ),
            _i32.RouteConfig(
              ToastmasterProfileManagementRouter.name,
              path: 'toastmasterProfileManagement',
              parent: ToastmasterHomeRouter.name,
            ),
          ],
        ),
        _i32.RouteConfig(
          SessionRedirectionRouter.name,
          path: '/sessionRedirection',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SessionRedirectionRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i32.RouteConfig(
          EditClubProfileRouter.name,
          path: '/editClubProfile',
          children: [
            _i32.RouteConfig(
              '*#redirect',
              path: '*',
              parent: EditClubProfileRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
      ];
}

/// generated route for
/// [_i1.UserTypeSelectionScreen]
class UserTypeSelectionRouter extends _i32.PageRouteInfo<void> {
  const UserTypeSelectionRouter({List<_i32.PageRouteInfo>? children})
      : super(
          UserTypeSelectionRouter.name,
          path: '/userType',
          initialChildren: children,
        );

  static const String name = 'UserTypeSelectionRouter';
}

/// generated route for
/// [_i2.LogInAsClubPresidentScreen]
class ClubPresidentLoginRouter extends _i32.PageRouteInfo<void> {
  const ClubPresidentLoginRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ClubPresidentLoginRouter.name,
          path: '/presidentLogin',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentLoginRouter';
}

/// generated route for
/// [_i3.LogInAsToastmasterScreen]
class ToastmasterLoginRouter extends _i32.PageRouteInfo<void> {
  const ToastmasterLoginRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ToastmasterLoginRouter.name,
          path: '/toastmasterLogin',
          initialChildren: children,
        );

  static const String name = 'ToastmasterLoginRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class EmptyRouterPageRoute extends _i32.PageRouteInfo<void> {
  const EmptyRouterPageRoute({List<_i32.PageRouteInfo>? children})
      : super(
          EmptyRouterPageRoute.name,
          path: '/guestLogin',
          initialChildren: children,
        );

  static const String name = 'EmptyRouterPageRoute';
}

/// generated route for
/// [_i5.ClubRegistrationScreen]
class ClubRegistrationRouter extends _i32.PageRouteInfo<void> {
  const ClubRegistrationRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ClubRegistrationRouter.name,
          path: '/clubRegistration',
          initialChildren: children,
        );

  static const String name = 'ClubRegistrationRouter';
}

/// generated route for
/// [_i6.ClubUsernameRegistrationScreen]
class ClubUsernameRegistrationRouter extends _i32.PageRouteInfo<void> {
  const ClubUsernameRegistrationRouter()
      : super(
          ClubUsernameRegistrationRouter.name,
          path: '/clubUsernameRegistration',
        );

  static const String name = 'ClubUsernameRegistrationRouter';
}

/// generated route for
/// [_i7.ClubSetUpRegistrationScreen]
class ClubSetUpRegistrationRouter extends _i32.PageRouteInfo<void> {
  const ClubSetUpRegistrationRouter()
      : super(
          ClubSetUpRegistrationRouter.name,
          path: '/clubSetUp',
        );

  static const String name = 'ClubSetUpRegistrationRouter';
}

/// generated route for
/// [_i8.ClubProfileManagementScreen]
class ClubProfileAnnouncementViewRouter
    extends _i32.PageRouteInfo<ClubProfileAnnouncementViewRouterArgs> {
  ClubProfileAnnouncementViewRouter({
    _i33.Key? key,
    required bool forViewOnly,
    required bool fromAnnouncementPage,
    String? clubId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          ClubProfileAnnouncementViewRouter.name,
          path: '/clubProfileAnnouncementView',
          args: ClubProfileAnnouncementViewRouterArgs(
            key: key,
            forViewOnly: forViewOnly,
            fromAnnouncementPage: fromAnnouncementPage,
            clubId: clubId,
          ),
          initialChildren: children,
        );

  static const String name = 'ClubProfileAnnouncementViewRouter';
}

class ClubProfileAnnouncementViewRouterArgs {
  const ClubProfileAnnouncementViewRouterArgs({
    this.key,
    required this.forViewOnly,
    required this.fromAnnouncementPage,
    this.clubId,
  });

  final _i33.Key? key;

  final bool forViewOnly;

  final bool fromAnnouncementPage;

  final String? clubId;

  @override
  String toString() {
    return 'ClubProfileAnnouncementViewRouterArgs{key: $key, forViewOnly: $forViewOnly, fromAnnouncementPage: $fromAnnouncementPage, clubId: $clubId}';
  }
}

/// generated route for
/// [_i9.ManageMemeberAccountFromSetUpScreen]
class SetAndManageMemberAccountRouter
    extends _i32.PageRouteInfo<SetAndManageMemberAccountRouterArgs> {
  SetAndManageMemberAccountRouter({
    _i33.Key? key,
    required bool isInEditMode,
    List<_i32.PageRouteInfo>? children,
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

  final _i33.Key? key;

  final bool isInEditMode;

  @override
  String toString() {
    return 'SetAndManageMemberAccountRouterArgs{key: $key, isInEditMode: $isInEditMode}';
  }
}

/// generated route for
/// [_i10.ClubMembersManagementScreen]
class ClubMembersManagementSetUpRouter
    extends _i32.PageRouteInfo<ClubMembersManagementSetUpRouterArgs> {
  ClubMembersManagementSetUpRouter({
    _i33.Key? key,
    required bool fromSetUpRouter,
    List<_i32.PageRouteInfo>? children,
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

  final _i33.Key? key;

  final bool fromSetUpRouter;

  @override
  String toString() {
    return 'ClubMembersManagementSetUpRouterArgs{key: $key, fromSetUpRouter: $fromSetUpRouter}';
  }
}

/// generated route for
/// [_i11.ClubPresidentHomeScreen]
class ClubPresidentHomeRouter extends _i32.PageRouteInfo<void> {
  const ClubPresidentHomeRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ClubPresidentHomeRouter.name,
          path: '/clubPresidentHomeScreen',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentHomeRouter';
}

/// generated route for
/// [_i12.ToastmasterHomeScreen]
class ToastmasterHomeRouter extends _i32.PageRouteInfo<void> {
  const ToastmasterHomeRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ToastmasterHomeRouter.name,
          path: '/toastmasterHomeScreen',
          initialChildren: children,
        );

  static const String name = 'ToastmasterHomeRouter';
}

/// generated route for
/// [_i13.SessionRedirectionScreen]
class SessionRedirectionRouter
    extends _i32.PageRouteInfo<SessionRedirectionRouterArgs> {
  SessionRedirectionRouter({
    _i33.Key? key,
    required bool isAGuest,
    String? chapterMeetingId,
    String? chapterMeetingInvitationCode,
    bool? guestHasRole,
    String? guestInvitationCode,
    String? toastmasterId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          SessionRedirectionRouter.name,
          path: '/sessionRedirection',
          args: SessionRedirectionRouterArgs(
            key: key,
            isAGuest: isAGuest,
            chapterMeetingId: chapterMeetingId,
            chapterMeetingInvitationCode: chapterMeetingInvitationCode,
            guestHasRole: guestHasRole,
            guestInvitationCode: guestInvitationCode,
            toastmasterId: toastmasterId,
          ),
          initialChildren: children,
        );

  static const String name = 'SessionRedirectionRouter';
}

class SessionRedirectionRouterArgs {
  const SessionRedirectionRouterArgs({
    this.key,
    required this.isAGuest,
    this.chapterMeetingId,
    this.chapterMeetingInvitationCode,
    this.guestHasRole,
    this.guestInvitationCode,
    this.toastmasterId,
  });

  final _i33.Key? key;

  final bool isAGuest;

  final String? chapterMeetingId;

  final String? chapterMeetingInvitationCode;

  final bool? guestHasRole;

  final String? guestInvitationCode;

  final String? toastmasterId;

  @override
  String toString() {
    return 'SessionRedirectionRouterArgs{key: $key, isAGuest: $isAGuest, chapterMeetingId: $chapterMeetingId, chapterMeetingInvitationCode: $chapterMeetingInvitationCode, guestHasRole: $guestHasRole, guestInvitationCode: $guestInvitationCode, toastmasterId: $toastmasterId}';
  }
}

/// generated route for
/// [_i14.EditClubProfileDetailsScreen]
class EditClubProfileRouter extends _i32.PageRouteInfo<void> {
  const EditClubProfileRouter({List<_i32.PageRouteInfo>? children})
      : super(
          EditClubProfileRouter.name,
          path: '/editClubProfile',
          initialChildren: children,
        );

  static const String name = 'EditClubProfileRouter';
}

/// generated route for
/// [_i15.LogInAsGuestScreen]
class GuestLoginRouter extends _i32.PageRouteInfo<void> {
  const GuestLoginRouter()
      : super(
          GuestLoginRouter.name,
          path: '',
        );

  static const String name = 'GuestLoginRouter';
}

/// generated route for
/// [_i16.GuestRoleInvitationCodeScreen]
class GuestRoleInvitationCodeRouter
    extends _i32.PageRouteInfo<GuestRoleInvitationCodeRouterArgs> {
  GuestRoleInvitationCodeRouter({
    _i33.Key? key,
    required String chapterMeetingInvitationCode,
  }) : super(
          GuestRoleInvitationCodeRouter.name,
          path: 'guestRoleInvitationCode',
          args: GuestRoleInvitationCodeRouterArgs(
            key: key,
            chapterMeetingInvitationCode: chapterMeetingInvitationCode,
          ),
        );

  static const String name = 'GuestRoleInvitationCodeRouter';
}

class GuestRoleInvitationCodeRouterArgs {
  const GuestRoleInvitationCodeRouterArgs({
    this.key,
    required this.chapterMeetingInvitationCode,
  });

  final _i33.Key? key;

  final String chapterMeetingInvitationCode;

  @override
  String toString() {
    return 'GuestRoleInvitationCodeRouterArgs{key: $key, chapterMeetingInvitationCode: $chapterMeetingInvitationCode}';
  }
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClubPresidentDashboardRouter extends _i32.PageRouteInfo<void> {
  const ClubPresidentDashboardRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ClubPresidentDashboardRouter.name,
          path: 'clubPresidentDashboard',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentDashboardRouter';
}

/// generated route for
/// [_i8.ClubProfileManagementScreen]
class ClubProfileManagementRouter
    extends _i32.PageRouteInfo<ClubProfileManagementRouterArgs> {
  ClubProfileManagementRouter({
    _i33.Key? key,
    required bool forViewOnly,
    required bool fromAnnouncementPage,
    String? clubId,
  }) : super(
          ClubProfileManagementRouter.name,
          path: 'clubProfileManagement',
          args: ClubProfileManagementRouterArgs(
            key: key,
            forViewOnly: forViewOnly,
            fromAnnouncementPage: fromAnnouncementPage,
            clubId: clubId,
          ),
        );

  static const String name = 'ClubProfileManagementRouter';
}

class ClubProfileManagementRouterArgs {
  const ClubProfileManagementRouterArgs({
    this.key,
    required this.forViewOnly,
    required this.fromAnnouncementPage,
    this.clubId,
  });

  final _i33.Key? key;

  final bool forViewOnly;

  final bool fromAnnouncementPage;

  final String? clubId;

  @override
  String toString() {
    return 'ClubProfileManagementRouterArgs{key: $key, forViewOnly: $forViewOnly, fromAnnouncementPage: $fromAnnouncementPage, clubId: $clubId}';
  }
}

/// generated route for
/// [_i17.PresidentDashboardScreen]
class PresidentDashboardScreenRoute extends _i32.PageRouteInfo<void> {
  const PresidentDashboardScreenRoute({List<_i32.PageRouteInfo>? children})
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
    extends _i32.PageRouteInfo<ClubMembersManagementRouterArgs> {
  ClubMembersManagementRouter({
    _i33.Key? key,
    required bool fromSetUpRouter,
    List<_i32.PageRouteInfo>? children,
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

  final _i33.Key? key;

  final bool fromSetUpRouter;

  @override
  String toString() {
    return 'ClubMembersManagementRouterArgs{key: $key, fromSetUpRouter: $fromSetUpRouter}';
  }
}

/// generated route for
/// [_i18.ManageMemberAccountScreen]
class ManageAccountRouter extends _i32.PageRouteInfo<ManageAccountRouterArgs> {
  ManageAccountRouter({
    _i33.Key? key,
    required bool isInEditMode,
    required bool isTheUserPresidentl,
    String? userId,
    List<_i32.PageRouteInfo>? children,
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

  final _i33.Key? key;

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
class ToastmasterDashboardRouter extends _i32.PageRouteInfo<void> {
  const ToastmasterDashboardRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ToastmasterDashboardRouter.name,
          path: 'toastmasterDashboard',
          initialChildren: children,
        );

  static const String name = 'ToastmasterDashboardRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ToastmasterScheduledMeetingsRouter extends _i32.PageRouteInfo<void> {
  const ToastmasterScheduledMeetingsRouter({List<_i32.PageRouteInfo>? children})
      : super(
          ToastmasterScheduledMeetingsRouter.name,
          path: 'scheduledMeetings',
          initialChildren: children,
        );

  static const String name = 'ToastmasterScheduledMeetingsRouter';
}

/// generated route for
/// [_i19.ToastmasterProfileManagementScreen]
class ToastmasterProfileManagementRouter extends _i32.PageRouteInfo<void> {
  const ToastmasterProfileManagementRouter()
      : super(
          ToastmasterProfileManagementRouter.name,
          path: 'toastmasterProfileManagement',
        );

  static const String name = 'ToastmasterProfileManagementRouter';
}

/// generated route for
/// [_i20.ToastmasterDashboardScreen]
class ToastmasterDashboardScreenRoute extends _i32.PageRouteInfo<void> {
  const ToastmasterDashboardScreenRoute({List<_i32.PageRouteInfo>? children})
      : super(
          ToastmasterDashboardScreenRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'ToastmasterDashboardScreenRoute';
}

/// generated route for
/// [_i21.ManageComingSessionsScreen]
class ManageComingSessionsRouter extends _i32.PageRouteInfo<void> {
  const ManageComingSessionsRouter()
      : super(
          ManageComingSessionsRouter.name,
          path: 'manageComingSessions',
        );

  static const String name = 'ManageComingSessionsRouter';
}

/// generated route for
/// [_i22.PrepareMeetingAgendaScreen]
class PrepareMeetingAgendaRouter
    extends _i32.PageRouteInfo<PrepareMeetingAgendaRouterArgs> {
  PrepareMeetingAgendaRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  @override
  String toString() {
    return 'PrepareMeetingAgendaRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId}';
  }
}

/// generated route for
/// [_i23.AllocateRolePlayerScreen]
class AllocateRolePlayerRouter
    extends _i32.PageRouteInfo<AllocateRolePlayerRouterArgs> {
  AllocateRolePlayerRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'AllocateRolePlayerRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i24.AskForVolunteersScreen]
class AskForVolunteersRouter
    extends _i32.PageRouteInfo<AskForVolunteersRouterArgs> {
  AskForVolunteersRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  final bool viewMode;

  final String clubId;

  @override
  String toString() {
    return 'AskForVolunteersRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, viewMode: $viewMode, clubId: $clubId}';
  }
}

/// generated route for
/// [_i25.ManageChapterMeetingAnnouncementsScreen]
class ManageChapterMeetingAnnouncementsRouter
    extends _i32.PageRouteInfo<ManageChapterMeetingAnnouncementsRouterArgs> {
  ManageChapterMeetingAnnouncementsRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'ManageChapterMeetingAnnouncementsRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i26.AnnounceChapterMeetingScreen]
class AnnounceChapterMeetingRouter
    extends _i32.PageRouteInfo<AnnounceChapterMeetingRouterArgs> {
  AnnounceChapterMeetingRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'AnnounceChapterMeetingRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i27.ChapterMeetingAnnouncementViewScreen]
class ChapterMeetingAnnouncementViewRouter
    extends _i32.PageRouteInfo<ChapterMeetingAnnouncementViewRouterArgs> {
  ChapterMeetingAnnouncementViewRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  final bool viewedFromSearchPage;

  final String clubId;

  @override
  String toString() {
    return 'ChapterMeetingAnnouncementViewRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, viewedFromSearchPage: $viewedFromSearchPage, clubId: $clubId}';
  }
}

/// generated route for
/// [_i28.SearchChapterMeetingScreen]
class SearchChapterMeetingRouter extends _i32.PageRouteInfo<void> {
  const SearchChapterMeetingRouter()
      : super(
          SearchChapterMeetingRouter.name,
          path: 'searchChapterMeeting',
        );

  static const String name = 'SearchChapterMeetingRouter';
}

/// generated route for
/// [_i29.VolunteerAnnouncementViewDetailsScreen]
class VolunteerAnnouncementViewDetailsRouter
    extends _i32.PageRouteInfo<VolunteerAnnouncementViewDetailsRouterArgs> {
  VolunteerAnnouncementViewDetailsRouter({
    _i33.Key? key,
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

  final _i33.Key? key;

  final String chapterMeetingId;

  final String clubId;

  @override
  String toString() {
    return 'VolunteerAnnouncementViewDetailsRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId, clubId: $clubId}';
  }
}

/// generated route for
/// [_i30.ToastmasterScheduledMeetingsScreen]
class ToastmasterScheduledMeetingsScreenRoute extends _i32.PageRouteInfo<void> {
  const ToastmasterScheduledMeetingsScreenRoute()
      : super(
          ToastmasterScheduledMeetingsScreenRoute.name,
          path: '',
        );

  static const String name = 'ToastmasterScheduledMeetingsScreenRoute';
}

/// generated route for
/// [_i31.ViewScheduledMeetingDetailsScreen]
class ViewScheduledMeetingDetailsRouter
    extends _i32.PageRouteInfo<ViewScheduledMeetingDetailsRouterArgs> {
  ViewScheduledMeetingDetailsRouter({
    _i33.Key? key,
    required String chapterMeetingId,
  }) : super(
          ViewScheduledMeetingDetailsRouter.name,
          path: 'viewScheduledMeetingDetails',
          args: ViewScheduledMeetingDetailsRouterArgs(
            key: key,
            chapterMeetingId: chapterMeetingId,
          ),
        );

  static const String name = 'ViewScheduledMeetingDetailsRouter';
}

class ViewScheduledMeetingDetailsRouterArgs {
  const ViewScheduledMeetingDetailsRouterArgs({
    this.key,
    required this.chapterMeetingId,
  });

  final _i33.Key? key;

  final String chapterMeetingId;

  @override
  String toString() {
    return 'ViewScheduledMeetingDetailsRouterArgs{key: $key, chapterMeetingId: $chapterMeetingId}';
  }
}
