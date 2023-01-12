import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'IFirebaseInitializer.dart';

class FirebaseInitializer extends IFirebaseInitializer {
  @override
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
