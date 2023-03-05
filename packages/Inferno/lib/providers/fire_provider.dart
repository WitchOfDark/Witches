// import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import 'package:tamannaah/darkknight/error/fire_error.dart';

abstract class FireProvider {
  Future<FireError?> logIn({
    required String email,
    required String password,
  });

  Future<FireError?> logOut();

  Future<FireError?> signIn({
    required String email,
    required String password,
  });

  Future<FireError?> verify();

  Future<FireError?> reset({required String email});

  Future<FireError?> delete();

  // FirebaseAuth.instance.currentUser?.updatePhotoURL(photoURL)
  // FirebaseAuth.instance.currentUser?.reload()
  // FirebaseAuth.instance.currentUser?.unlink(providerId)
  // FirebaseAuth.instance.currentUser?.linkWithCredential(credential)
  // FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential)
  // FirebaseAuth.instance.currentUser?.linkWithPhoneNumber(phoneNumber)
}
