import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import 'package:darkknight/error/fire_error.dart';

import '../fire_service.dart';
import '../inferno_error.dart';
import 'fire_provider.dart';

class FireEmailProvider extends FireProvider {
  @override
  Future<FireError?> logIn({
    required String email,
    required String password,
  }) async {
    return fire(
      () async {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(userCredential.credential.toString());

        return FirebaseAuth.instance.currentUser != null ? null : fireAuthErrorMap['unknown-auth'];
      },
    );
  }

  @override
  Future<FireError?> signIn({
    required String email,
    required String password,
  }) {
    return fire(
      () async {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(userCredential.credential.toString());

        return FirebaseAuth.instance.currentUser != null ? null : fireAuthErrorMap['unknown-auth'];
      },
    );
  }

  @override
  Future<FireError?> verify() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return null;
    }
    return fireAuthErrorMap['unknown-auth'];
  }

  @override
  Future<FireError?> reset({required String email}) {
    return fire(
      () async {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return null;
      },
    );
  }

  @override
  Future<FireError?> delete() {
    return fire(
      () async {
        await FirebaseAuth.instance.currentUser?.delete();
        return null;
      },
    );
  }

  @override
  Future<FireError?> logOut() {
    return fire(
      () async {
        await FireService.logOut();
        return null;
      },
    );
  }
}
