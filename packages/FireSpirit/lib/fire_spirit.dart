import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseOptions;

import 'package:tamannaah/darkknight/error/fire_error.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

class FireSpirit {
  static Future<void> spiritAwake(FirebaseOptions? fireOptions) async {
    final exp = await fire(() async {
      await Firebase.initializeApp(options: fireOptions);
      await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: 'recaptcha-v3-site-key',
        androidProvider: AndroidProvider.playIntegrity,
      );
      return null;
    });

    lava('Firebase options error : ${exp?.toMap()}');
  }
}
