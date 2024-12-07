import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp();
    // await Firebase.initializeApp(
    //     options: const FirebaseOptions(
    //   apiKey: "AIzaSyBmLLBiitO9YkH424Q5wdInxR72cbberFQ",
    //   appId: "1:351145816976:android:05b094bfc9890ae3a8f915",
    //   messagingSenderId: "351145816976",
    //   projectId: "todoapp-16793",
    // ));

    await _firebaseMessaging.requestPermission();
    token = await _firebaseMessaging.getToken();
  }
}
