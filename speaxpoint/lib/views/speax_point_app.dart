import 'package:flutter/material.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/app/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/view_models/authentication_vm/club_registration_view_model.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_members_management_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/manage_member_account_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/ask_for_volunteers_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_chapter_meeting_announcement_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_coming_sessions_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/grammatical_observation_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/manage_evaluation_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/manage_roles_players_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/speech_observations_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/speech_timing_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_live_session/time_filler_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/profile_management_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/scheduled_meetings_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/search_chapter_meeting_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/session_redirection_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/volunteer_announcement_view_details_view_model.dart';

class SpeaxPointApp extends StatelessWidget {
  SpeaxPointApp({super.key});
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ClubRegistrationViewModel>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<LogInViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ManageMemberAccountViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ClubMembersManagementViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ProfileManagementViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ManageComingSessionsViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<PrepareMeetingAgendaViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<AllocateRolePlayersViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<AskForVolunteersViewModel>()),
        ChangeNotifierProvider(
            create: (_) =>
                serviceLocator<ManageChapterMeetingAnnouncementViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<SearchChapterMeetingViewModel>()),
        ChangeNotifierProvider(
            create: (_) =>
                serviceLocator<VolunteerAnnouncementViewDetailsViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ScheduledMeetingsViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<SessionRedirectionViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ManageRolesPlayersViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<ManageEvaluationViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<SpeechTimingViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<TimeFillerViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<GrammaticalObservationViewModel>()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<SpeechObservationsViewModel>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: "SpeaXPoint",
      ),
    );
  }
}
