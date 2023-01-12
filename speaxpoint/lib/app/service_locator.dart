import 'package:get_it/get_it.dart';
import 'package:speaxpoint/services/firebaseInitializer/FirebaseInitializer.dart';
import 'package:speaxpoint/services/firebaseInitializer/IFirebaseInitializer.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  serviceLocator
      .registerLazySingleton<IFirebaseInitializer>(() => FirebaseInitializer());
  final firebaseInitializer = serviceLocator<IFirebaseInitializer>();
  await firebaseInitializer.initializeFirebase();
}
