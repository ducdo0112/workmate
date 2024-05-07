import 'package:firebase_core/firebase_core.dart';
import 'package:workmate/utils/logger.dart';

class FirebaseService {
  static Future<void> setUpFirebaseService() async {
    try {
      await Firebase.initializeApp();
    }catch (e) {
      logger.e("Setup firebase error: $e");
    }
  }
}