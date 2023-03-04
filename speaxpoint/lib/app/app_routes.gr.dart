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
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i15;
import 'package:flutter/src/widgets/framework.dart' as _i16;
import 'package:speaxpoint/views/club_president_user/club_member_management_screen/club_members_management_screen.dart'
    as _i13;
import 'package:speaxpoint/views/club_president_user/club_president_home_screen.dart'
    as _i6;
import 'package:speaxpoint/views/club_president_user/dashboard/president_dashboard_screen.dart'
    as _i12;
import 'package:speaxpoint/views/club_president_user/profile_management/club_profile_managment_screen.dart'
    as _i5;
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_registration_screen.dart'
    as _i9;
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_setup_registrationScreen.dart'
    as _i11;
import 'package:speaxpoint/views/user_authentication/club_registration_screens/club_username_registration_screen.dart'
    as _i10;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_as_toastmaster_screen.dart'
    as _i3;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_club_president/log_in_club_president_screen.dart'
    as _i2;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/guest_favorite_name_screen.dart'
    as _i8;
import 'package:speaxpoint/views/user_authentication/log_in_screens/log_in_guest/log_in_as_guest_screen.dart'
    as _i7;
import 'package:speaxpoint/views/user_authentication/log_in_screens/user_type_selection_screen.dart'
    as _i1;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    UserTypeSelectionRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.UserTypeSelectionScreen(),
      );
    },
    ClubPresidentLoginRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.LogInAsClubPresidentScreen(),
      );
    },
    ToastmasterLoginRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.LogInAsToastmasterScreen(),
      );
    },
    EmptyRouterPageRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubRegistrationRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubProfileManagementSetUpRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.ClubProfileManagementScreen(),
      );
    },
    ClubPresidentHomeRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.ClubPresidentHomeScreen(),
      );
    },
    GuestLoginRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.LogInAsGuestScreen(),
      );
    },
    GuestFavoriteNameRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GuestFavoriteNameRouterArgs>(
          orElse: () => GuestFavoriteNameRouterArgs(
              guestHasRole: pathParams.getBool('guestHasRole')));
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.GuestFavoriteNameScreen(
          key: args.key,
          guestHasRole: args.guestHasRole,
        ),
      );
    },
    ClubRegistrationScreenRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i9.ClubRegistrationScreen(),
      );
    },
    ClubUsernameRegistrationRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.ClubUsernameRegistrationScreen(),
      );
    },
    ClubSetUpRegistrationRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.ClubSetUpRegistrationScreen(),
      );
    },
    ClubPresidentDashboardRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.PresidentDashboardScreen(),
      );
    },
    ClubProfileManagementRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubMembersManagementRouter.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ClubProfileManagementScreenRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.ClubProfileManagementScreen(),
      );
    },
    ClubMembersManagementScreenRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.ClubMembersManagementScreen(),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/userType',
          fullMatch: true,
        ),
        _i14.RouteConfig(
          UserTypeSelectionRouter.name,
          path: '/userType',
          children: [
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: UserTypeSelectionRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i14.RouteConfig(
          ClubPresidentLoginRouter.name,
          path: '/presidentLogin',
          children: [
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubPresidentLoginRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i14.RouteConfig(
          ToastmasterLoginRouter.name,
          path: '/toastmasterLogin',
          children: [
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ToastmasterLoginRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i14.RouteConfig(
          EmptyRouterPageRoute.name,
          path: '/guestLogin',
          children: [
            _i14.RouteConfig(
              GuestLoginRouter.name,
              path: '',
              parent: EmptyRouterPageRoute.name,
            ),
            _i14.RouteConfig(
              GuestFavoriteNameRouter.name,
              path: 'favoriteName/:guestHasRole',
              parent: EmptyRouterPageRoute.name,
            ),
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: EmptyRouterPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i14.RouteConfig(
          ClubRegistrationRouter.name,
          path: '/clubRegistration',
          children: [
            _i14.RouteConfig(
              ClubRegistrationScreenRoute.name,
              path: '',
              parent: ClubRegistrationRouter.name,
            ),
            _i14.RouteConfig(
              ClubUsernameRegistrationRouter.name,
              path: 'clubUsernameRegistration',
              parent: ClubRegistrationRouter.name,
            ),
            _i14.RouteConfig(
              ClubSetUpRegistrationRouter.name,
              path: 'clubSetUp',
              parent: ClubRegistrationRouter.name,
            ),
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubRegistrationRouter.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i14.RouteConfig(
          ClubProfileManagementSetUpRouter.name,
          path: '/clubProfileManagement/:fromRegistrationSetup',
          children: [
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubProfileManagementSetUpRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i14.RouteConfig(
          ClubProfileManagementSetUpRouter.name,
          path: '/clubProfileManagement/:fromRegistrationSetup',
          children: [
            _i14.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ClubProfileManagementSetUpRouter.name,
              redirectTo: '',
              fullMatch: true,
            )
          ],
        ),
        _i14.RouteConfig(
          ClubPresidentHomeRouter.name,
          path: '/clubPresidentHomeScreen',
          children: [
            _i14.RouteConfig(
              ClubPresidentDashboardRouter.name,
              path: 'clubPresidentDashboard',
              parent: ClubPresidentHomeRouter.name,
              children: [
                _i14.RouteConfig(
                  ClubProfileManagementRouter.name,
                  path: 'clubProfileManagement/:fromRegistrationSetup',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i14.RouteConfig(
                      ClubProfileManagementScreenRoute.name,
                      path: '',
                      parent: ClubProfileManagementRouter.name,
                    ),
                    _i14.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ClubProfileManagementRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i14.RouteConfig(
                  ClubMembersManagementRouter.name,
                  path: 'clubMembersManagementScreen/:fromRegistrationSetup',
                  parent: ClubPresidentDashboardRouter.name,
                  children: [
                    _i14.RouteConfig(
                      ClubMembersManagementScreenRoute.name,
                      path: '',
                      parent: ClubMembersManagementRouter.name,
                    ),
                    _i14.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ClubMembersManagementRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
              ],
            ),
            _i14.RouteConfig(
              ClubProfileManagementRouter.name,
              path: 'clubProfileManagement/:fromRegistrationSetup',
              parent: ClubPresidentHomeRouter.name,
              children: [
                _i14.RouteConfig(
                  ClubProfileManagementScreenRoute.name,
                  path: '',
                  parent: ClubProfileManagementRouter.name,
                ),
                _i14.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: ClubProfileManagementRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.UserTypeSelectionScreen]
class UserTypeSelectionRouter extends _i14.PageRouteInfo<void> {
  const UserTypeSelectionRouter({List<_i14.PageRouteInfo>? children})
      : super(
          UserTypeSelectionRouter.name,
          path: '/userType',
          initialChildren: children,
        );

  static const String name = 'UserTypeSelectionRouter';
}

/// generated route for
/// [_i2.LogInAsClubPresidentScreen]
class ClubPresidentLoginRouter extends _i14.PageRouteInfo<void> {
  const ClubPresidentLoginRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubPresidentLoginRouter.name,
          path: '/presidentLogin',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentLoginRouter';
}

/// generated route for
/// [_i3.LogInAsToastmasterScreen]
class ToastmasterLoginRouter extends _i14.PageRouteInfo<void> {
  const ToastmasterLoginRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ToastmasterLoginRouter.name,
          path: '/toastmasterLogin',
          initialChildren: children,
        );

  static const String name = 'ToastmasterLoginRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class EmptyRouterPageRoute extends _i14.PageRouteInfo<void> {
  const EmptyRouterPageRoute({List<_i14.PageRouteInfo>? children})
      : super(
          EmptyRouterPageRoute.name,
          path: '/guestLogin',
          initialChildren: children,
        );

  static const String name = 'EmptyRouterPageRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClubRegistrationRouter extends _i14.PageRouteInfo<void> {
  const ClubRegistrationRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubRegistrationRouter.name,
          path: '/clubRegistration',
          initialChildren: children,
        );

  static const String name = 'ClubRegistrationRouter';
}

/// generated route for
/// [_i5.ClubProfileManagementScreen]
class ClubProfileManagementSetUpRouter extends _i14.PageRouteInfo<void> {
  const ClubProfileManagementSetUpRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubProfileManagementSetUpRouter.name,
          path: '/clubProfileManagement/:fromRegistrationSetup',
          initialChildren: children,
        );

  static const String name = 'ClubProfileManagementSetUpRouter';
}

/// generated route for
/// [_i6.ClubPresidentHomeScreen]
class ClubPresidentHomeRouter extends _i14.PageRouteInfo<void> {
  const ClubPresidentHomeRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubPresidentHomeRouter.name,
          path: '/clubPresidentHomeScreen',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentHomeRouter';
}

/// generated route for
/// [_i7.LogInAsGuestScreen]
class GuestLoginRouter extends _i14.PageRouteInfo<void> {
  const GuestLoginRouter()
      : super(
          GuestLoginRouter.name,
          path: '',
        );

  static const String name = 'GuestLoginRouter';
}

/// generated route for
/// [_i8.GuestFavoriteNameScreen]
class GuestFavoriteNameRouter
    extends _i14.PageRouteInfo<GuestFavoriteNameRouterArgs> {
  GuestFavoriteNameRouter({
    _i16.Key? key,
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

  final _i16.Key? key;

  final bool guestHasRole;

  @override
  String toString() {
    return 'GuestFavoriteNameRouterArgs{key: $key, guestHasRole: $guestHasRole}';
  }
}

/// generated route for
/// [_i9.ClubRegistrationScreen]
class ClubRegistrationScreenRoute extends _i14.PageRouteInfo<void> {
  const ClubRegistrationScreenRoute()
      : super(
          ClubRegistrationScreenRoute.name,
          path: '',
        );

  static const String name = 'ClubRegistrationScreenRoute';
}

/// generated route for
/// [_i10.ClubUsernameRegistrationScreen]
class ClubUsernameRegistrationRouter extends _i14.PageRouteInfo<void> {
  const ClubUsernameRegistrationRouter()
      : super(
          ClubUsernameRegistrationRouter.name,
          path: 'clubUsernameRegistration',
        );

  static const String name = 'ClubUsernameRegistrationRouter';
}

/// generated route for
/// [_i11.ClubSetUpRegistrationScreen]
class ClubSetUpRegistrationRouter extends _i14.PageRouteInfo<void> {
  const ClubSetUpRegistrationRouter()
      : super(
          ClubSetUpRegistrationRouter.name,
          path: 'clubSetUp',
        );

  static const String name = 'ClubSetUpRegistrationRouter';
}

/// generated route for
/// [_i12.PresidentDashboardScreen]
class ClubPresidentDashboardRouter extends _i14.PageRouteInfo<void> {
  const ClubPresidentDashboardRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubPresidentDashboardRouter.name,
          path: 'clubPresidentDashboard',
          initialChildren: children,
        );

  static const String name = 'ClubPresidentDashboardRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClubProfileManagementRouter extends _i14.PageRouteInfo<void> {
  const ClubProfileManagementRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubProfileManagementRouter.name,
          path: 'clubProfileManagement/:fromRegistrationSetup',
          initialChildren: children,
        );

  static const String name = 'ClubProfileManagementRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ClubMembersManagementRouter extends _i14.PageRouteInfo<void> {
  const ClubMembersManagementRouter({List<_i14.PageRouteInfo>? children})
      : super(
          ClubMembersManagementRouter.name,
          path: 'clubMembersManagementScreen/:fromRegistrationSetup',
          initialChildren: children,
        );

  static const String name = 'ClubMembersManagementRouter';
}

/// generated route for
/// [_i5.ClubProfileManagementScreen]
class ClubProfileManagementScreenRoute extends _i14.PageRouteInfo<void> {
  const ClubProfileManagementScreenRoute()
      : super(
          ClubProfileManagementScreenRoute.name,
          path: '',
        );

  static const String name = 'ClubProfileManagementScreenRoute';
}

/// generated route for
/// [_i13.ClubMembersManagementScreen]
class ClubMembersManagementScreenRoute extends _i14.PageRouteInfo<void> {
  const ClubMembersManagementScreenRoute()
      : super(
          ClubMembersManagementScreenRoute.name,
          path: '',
        );

  static const String name = 'ClubMembersManagementScreenRoute';
}
