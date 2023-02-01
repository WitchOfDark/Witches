import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseOptions;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/fire_auth/fire_error.dart';
import '../../tools/debug_functions.dart';

import '../bloc_service.dart';
import 'bloc/fire_auth_bloc.dart';
import 'fire_user.dart';
import 'providers/fire_email_provider.dart';
import 'providers/fire_google_provider.dart';
import 'providers/fire_provider.dart';

enum FireMoon { email, google, facebook, apple, phone, custom }

class FireService implements Service {
  static Map<FireMoon, FireProvider> providers = {};

  static List<FireMoon> moons = [];

  @override
  bool initialized = false;

  @override
  Future<void> init() async {
    if (!initialized) {}
    initialized = true;
    dino('FireAuthService initialized');

    unicorn(user?.toString());
  }

  static FireUser? _fireUser;

  static FireUser? get user {
    if (providers.containsKey(FireMoon.custom)) {
      return _fireUser;
    }

    final user = FirebaseAuth.instance.currentUser;

    return user != null ? FireUser.fire(user) : null;
  }

  static FireUser? setUser(FireUser fireuser) {
    _fireUser = fireuser;
    return _fireUser;
  }

  static StreamController<bool> statusController = StreamController<bool>.broadcast();

  static Stream<bool> get status {
    lava('Fire Stream Status listening');
    if (providers.containsKey(FireMoon.custom)) {
      return statusController.stream;
      return Stream.value(false);
    }
    return FirebaseAuth.instance.userChanges().map((user) {
      dino(user.toString());
      return !(user == null);
    });
  }

  static Future<FireError?> logOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
      return null;
    }
    return fireAuthErrorMap['unknown-auth'];
  }

  Future<void> fireBloc({
    required List<BlocService> blocService,
    FirebaseOptions? fireOptions,
    List<FireMoon> fireMoons = const [],
    FireProvider? customAuthProvider,
  }) async {
    moons = fireMoons;

    if (fireMoons.contains(FireMoon.custom) && customAuthProvider != null) {
      providers[FireMoon.custom] = customAuthProvider;
    }

    if (fireOptions != null && !initialized) {
      final exp = await fire(() async {
        await Firebase.initializeApp(options: fireOptions);
        await FirebaseAppCheck.instance.activate(
          webRecaptchaSiteKey: 'recaptcha-v3-site-key',
          androidProvider: AndroidProvider.playIntegrity,
        );
        return null;
      });

      lava('Firebase options error : ${exp?.toMap()}');

      if (fireMoons.contains(FireMoon.email)) {
        providers[FireMoon.email] = FireEmailProvider();
      }
      if (fireMoons.contains(FireMoon.google)) {
        providers[FireMoon.google] = FireGoogleProvider(scopes: []);
      }
      if (fireMoons.contains(FireMoon.facebook)) {
        // providers[FireServices.facebook] = FireFacebookProvider();
      }
      if (fireMoons.contains(FireMoon.apple)) {
        // providers[FireServices.apple] = FireAppleProvider();
      }
      // if (fireMoons.contains(FireMoon.phone)) {
      //   // providers[FireMoon.phone] = FirePhoneProvider();
      // }
    }

    if (providers.isNotEmpty) {
      lava(providers.keys.toList());

      blocService.add(
        BlocService(
          service: this,
          // serviceProvider: () {
          //   return null;
          // },
          blocProvider: () {
            return BlocProvider<FireAuthBloc>(
              create: (context) => FireAuthBloc(),
            );
          },
        ),
      );
    }
  }
}
