import 'package:get_it/get_it.dart';
import 'package:speaxpoint/services/authentication/authentication_firebase_service.dart';
import 'package:speaxpoint/services/authentication/i_authentication_service.dart';
import 'package:speaxpoint/services/firebaseInitializer/firebase_initializer.dart';
import 'package:speaxpoint/services/firebaseInitializer/i_firebase_initializer_service.dart';
import 'package:speaxpoint/services/local_database/i_local_database_service.dart';
import 'package:speaxpoint/services/local_database/local_database_shared_preferences_service.dart';
import 'package:speaxpoint/services/manage_club_members/i_manage_club_members_service.dart';
import 'package:speaxpoint/services/manage_club_members/manage_club_members_firebase_service.dart';
import 'package:speaxpoint/view_models/authentication_vm/club_registration_view_model.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_members_management_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/manage_member_account_view_model.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/profile_management_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  serviceLocator.registerLazySingleton<IFirebaseInitializerService>(
      () => FirebaseInitializer());
  final firebaseInitializer = serviceLocator<IFirebaseInitializerService>();
  await firebaseInitializer.initializeFirebase();

//the local database

//this part is for the services objects
  serviceLocator.registerLazySingleton<IAuthenticationService>(
      () => AuthenticationFirebaseService());

  serviceLocator.registerLazySingleton<ILocalDataBaseService>(
    () => LocalDataBaseSharedPreferencesService(),
  );

  serviceLocator.registerLazySingleton<IManageClubMembersService>(
    () => ManageClubMembersFirebaseService(),
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
          ));
}
