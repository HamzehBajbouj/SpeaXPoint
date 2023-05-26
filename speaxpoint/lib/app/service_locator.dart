import 'package:get_it/get_it.dart';
import 'package:speaxpoint/services/authentication/authentication_firebase_service.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/services/firebaseInitializer/firebase_initializer.dart';
import 'package:speaxpoint/services/firebaseInitializer/i_firebase_initializer_service.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/local_database/local_database_shared_preferences_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/allocate_role_player_firebase_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/allocate_role_players/i_allocate_role_players_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/ask_for_volunteers_firebase_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/ask_for_volunteers/i_ask_for_volunteers_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/i_manage_meeting_agenda_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_agenda/manage_meeting_agenda_firebase_service.dart';
import 'package:speaxpoint/services/manage_club_members/i_manage_club_members_service.dart';
import 'package:speaxpoint/services/manage_club_members/manage_club_members_firebase_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/i_manage_chapter_meeting_announcements_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_announcements/manage_chpater_meeting_announcements_firebase_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_coming_sessions/i_manage_coming_sessions_service.dart';
import 'package:speaxpoint/services/meeting_arrangement/manage_coming_sessions/manage_coming_sessions_firebase_serivce.dart';
import 'package:speaxpoint/services/scheduled_meeting_management/i_scheduled_meeting_management_service.dart';
import 'package:speaxpoint/services/scheduled_meeting_management/scheduled_meeting_management_firebase_service.dart';
import 'package:speaxpoint/services/search_chapter_meeting/i_search_chapter_meeting_service.dart';
import 'package:speaxpoint/services/search_chapter_meeting/search_chapter_meeting_firebase_service.dart';
import 'package:speaxpoint/services/session_redirection/i_session_redirection_service.dart';
import 'package:speaxpoint/services/session_redirection/session_redirection_firebase_service.dart';
import 'package:speaxpoint/view_models/authentication_vm/club_registration_view_model.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_members_management_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/manage_member_account_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/ask_for_volunteers_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_chapter_meeting_announcement_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/manage_coming_sessions_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/prepare_meeting_agenda_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/profile_management_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/scheduled_meetings_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/search_chapter_meeting_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/session_redirection_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/volunteer_announcement_view_details_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  serviceLocator.registerLazySingleton<IFirebaseInitializerService>(
      () => FirebaseInitializer());
  final firebaseInitializer = serviceLocator<IFirebaseInitializerService>();
  await firebaseInitializer.initializeFirebase();

//the local database
  serviceLocator.registerLazySingleton<ILocalDataBaseService>(
    () => LocalDataBaseSharedPreferencesService(),
  );
//this part is for the services objects
  serviceLocator.registerLazySingleton<IAuthenticationService>(() =>
      AuthenticationFirebaseService(serviceLocator<ILocalDataBaseService>()));

  serviceLocator.registerLazySingleton<IManageClubMembersService>(
    () => ManageClubMembersFirebaseService(),
  );

  serviceLocator.registerLazySingleton<IManageComingSessionsService>(
    () => ManageComingSessionsFirebaseSerivce(),
  );

  serviceLocator.registerLazySingleton<IManageMeetingAgendaService>(
    () => ManageMeetingAgendaFirebaseSerivce(),
  );

  serviceLocator.registerLazySingleton<IAllocateRolePlayersService>(
    () => AllocateRolePlayerFirebaseService(),
  );

  serviceLocator.registerLazySingleton<IAskForVolunteersService>(
    () => AskForVolunteersFirebaseService(),
  );

  serviceLocator
      .registerLazySingleton<IManageChapterMeeingAnnouncementsService>(
    () => ManageChapterMeetingAnnouncementsFirebaseService(),
  );
  serviceLocator.registerLazySingleton<ISearchChapterMeetingService>(
    () => SearchChapterMeetingFirebaseService(),
  );

  serviceLocator.registerLazySingleton<IScheduledMeetingManagementService>(
    () => ScheduledMeetingManagementFirebaseService(),
  );

  serviceLocator.registerLazySingleton<ISessionRedirectionService>(
    () => SessionRedirectionFirebaseService(),
  );

//this part is for the viewmodels objects
  serviceLocator.registerLazySingleton<ClubRegistrationViewModel>(
    () => ClubRegistrationViewModel(
      serviceLocator<IAuthenticationService>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => LogInViewModel(
      serviceLocator<IAuthenticationService>(),
    ),
  );

  serviceLocator.registerLazySingleton<ManageMemberAccountViewModel>(
    () => ManageMemberAccountViewModel(
      serviceLocator<IManageClubMembersService>(),
      serviceLocator<IAuthenticationService>(),
    ),
  );

  serviceLocator.registerLazySingleton<ClubMembersManagementViewModel>(
    () => ClubMembersManagementViewModel(
        serviceLocator<IManageClubMembersService>()),
  );

  serviceLocator.registerLazySingleton<ProfileManagementViewModel>(
    () => ProfileManagementViewModel(
      serviceLocator<IManageClubMembersService>(),
      serviceLocator<IAuthenticationService>(),
    ),
  );

  serviceLocator.registerLazySingleton<ManageComingSessionsViewModel>(
    () => ManageComingSessionsViewModel(
      serviceLocator<ILocalDataBaseService>(),
      serviceLocator<IManageComingSessionsService>(),
    ),
  );

  serviceLocator.registerLazySingleton<PrepareMeetingAgendaViewModel>(
    () => PrepareMeetingAgendaViewModel(
        serviceLocator<IManageMeetingAgendaService>()),
  );

  serviceLocator.registerLazySingleton<AllocateRolePlayersViewModel>(
    () => AllocateRolePlayersViewModel(
      serviceLocator<IAllocateRolePlayersService>(),
      serviceLocator<IManageMeetingAgendaService>(),
      serviceLocator<IAskForVolunteersService>(),
    ),
  );

  serviceLocator.registerLazySingleton<AskForVolunteersViewModel>(
    () => AskForVolunteersViewModel(
      serviceLocator<IAskForVolunteersService>(),
      serviceLocator<IManageMeetingAgendaService>(),
      serviceLocator<IManageChapterMeeingAnnouncementsService>(),
    ),
  );

  serviceLocator
      .registerLazySingleton<ManageChapterMeetingAnnouncementViewModel>(
    () => ManageChapterMeetingAnnouncementViewModel(
      serviceLocator<IManageChapterMeeingAnnouncementsService>(),
      serviceLocator<IManageMeetingAgendaService>(),
    ),
  );
  serviceLocator.registerLazySingleton<SearchChapterMeetingViewModel>(
    () => SearchChapterMeetingViewModel(
      serviceLocator<ISearchChapterMeetingService>(),
      serviceLocator<ILocalDataBaseService>(),
    ),
  );

  serviceLocator
      .registerLazySingleton<VolunteerAnnouncementViewDetailsViewModel>(
    () => VolunteerAnnouncementViewDetailsViewModel(
      serviceLocator<IAskForVolunteersService>(),
      serviceLocator<IManageChapterMeeingAnnouncementsService>(),
      serviceLocator<ILocalDataBaseService>(),
    ),
  );

  serviceLocator.registerLazySingleton<ScheduledMeetingsViewModel>(
    () => ScheduledMeetingsViewModel(
      serviceLocator<IScheduledMeetingManagementService>(),
    ),
  );
  serviceLocator.registerLazySingleton<SessionRedirectionViewModel>(
    () => SessionRedirectionViewModel(
      serviceLocator<ISessionRedirectionService>(),
    ),
  );
}
