import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'i_firebase_initializer_service.dart';

class FirebaseInitializer extends IFirebaseInitializerService {
  @override
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
