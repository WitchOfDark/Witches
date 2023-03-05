import 'package:darkknight/debug_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, GoogleAuthProvider, UserCredential;

import 'package:google_sign_in/google_sign_in.dart';

import 'package:darkknight/error/fire_error.dart';

import 'package:inferno/fire_service.dart';
import 'package:inferno/inferno_error.dart';
import 'package:inferno/providers/fire_provider.dart';

class FireGoogleProvider extends FireProvider {
  late GoogleSignIn google;
  GoogleSignInAccount? gUser;

  FireGoogleProvider({required List<String> scopes}) {
    google = GoogleSignIn(
      scopes: [
        'openid',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
        ...scopes,
      ],
    );
  }

  @override
  Future<FireError?> logIn({required String email, required String password}) {
    return fire(
      () async {
        gUser = await google.signIn();
        unicorn(await gUser?.authHeaders);
        unicorn(gUser.toString());

        final GoogleSignInAuthentication? googleAuth = await gUser?.authentication;

        final gCred = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        unicorn(gCred.asMap());

        UserCredential uCred = await FirebaseAuth.instance.signInWithCredential(gCred);
        unicorn(uCred.credential?.asMap());
        unicorn(uCred.additionalUserInfo.toString());
        unicorn(uCred.credential?.accessToken);

        dino(FireService.user?.toMap());

        return null;
      },
    );
  }

  @override
  Future<FireError?> logOut() async {
    return fire(() async {
      if (await google.isSignedIn()) {
        GoogleSignInAccount? g = await google.disconnect();
        lava('Google is signed in : ${(await google.isSignedIn())}');
        lava(g.toString());
      }

      await FireService.logOut();

      return !(await google.isSignedIn()) ? null : fireAuthErrorMap['unknown-auth'];
    });
  }

  @override
  Future<FireError?> reset({required String email}) async {
    return null;
  }

  @override
  Future<FireError?> signIn({required String email, required String password}) async {
    return null;
  }

  @override
  Future<FireError?> verify() async {
    return null;
  }

  @override
  Future<FireError?> delete() async {
    return null;
  }
}
