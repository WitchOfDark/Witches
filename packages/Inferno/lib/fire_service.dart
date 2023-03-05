import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import 'package:tamannaah/darkknight/bloc_service.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

import 'bloc/fire_auth_bloc.dart';

import 'package:tamannaah/darkknight/error/fire_error.dart';

import 'fire_user.dart';
import 'inferno_error.dart';
import 'providers/fire_email_provider.dart';
import 'providers/fire_provider.dart';

enum FireMoon { email, google, facebook, apple, phone, custom }

class FireService implements Service {
  static Map<FireMoon, FireProvider> providers = {};

  static List<FireMoon> moons = [];

  static FireProvider? googleAuthProvider;
  static FireProvider? customAuthProvider;

  @override
  bool initialized = false;

  @override
  Future<void> init([dynamic obj]) async {
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
      // return Stream.value(false);
    }
    return FirebaseAuth.instance.userChanges().map((user) {
      dino(user.toString());
      return !(user == null);
    });
  }

  static Future<FireError?> logOut() async {
    customAuthProvider?.logOut();
    googleAuthProvider?.logOut();

    // try {
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     await FirebaseAuth.instance.signOut();
    //     return null;
    //   }
    // } catch (e) {
    //   lava('No Firebase App');
    // }
    return fireAuthErrorMap['unknown-auth'];
  }

  Future<void> fireBloc({
    required List<BlocService> blocService,
    List<FireMoon> fireMoons = const [],
    FireProvider? googleProvider,
    FireProvider? customProvider,
  }) async {
    moons = fireMoons;

    customAuthProvider = customProvider;
    googleAuthProvider = googleProvider;

    if (fireMoons.contains(FireMoon.custom) && customProvider != null) {
      providers[FireMoon.custom] = customProvider;
    }

    if (!initialized) {
      if (fireMoons.contains(FireMoon.email)) {
        providers[FireMoon.email] = FireEmailProvider();
      }
      if (fireMoons.contains(FireMoon.google) && googleProvider != null) {
        providers[FireMoon.google] = googleProvider;
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
