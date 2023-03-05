import 'package:tamannaah/darkknight/error/fire_error.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

AttackMode infernoFire = (Future<FireError?> Function() v) async {
  try {
    return (await v());
  } on FirebaseAuthException catch (e) {
    return // fireAuthErrorMap[e.code.toLowerCase().trim()] ??
        FireError(
      title: 'Firebase Auth Exception',
      text: '🍄 ${e.code} : ${e.message}',
    );
  } on FirebaseException catch (e) {
    return // fireErrorMap[e.code.toLowerCase().trim()] ??
        FireError(
      title: 'Firebase core Exception',
      text: '🍄 ${e.code} : ${e.message}',
    );
  } on FileSystemException catch (e) {
    return FireError(
      title: 'File System Exception',
      text: '🍄 ${e.message}',
    );
  } on FormatException catch (e) {
    return FireError(
      title: 'Format Exception',
      text: '🍨 ${e.message}',
    );
  } on TimeoutException catch (e) {
    return FireError(
      title: 'Timeout Exception',
      text: '🥗 ${e.message}',
    );
  } on SocketException catch (e) {
    return FireError(
      title: 'Socket Exception',
      text: '🍒 ${e.message}',
    );
  } on PlatformException catch (e) {
    return FireError(
      title: 'Platform Exception',
      text: '☕ ${e.message}',
    );
  } on NoSuchMethodError catch (e) {
    return FireError(
      title: 'No Such Method Exception',
      text: '🍰 $e',
    );
  } on Exception catch (e) {
    return FireError(
      title: 'Error : ${e.runtimeType.toString()}',
      text: '🎂 $e',
    );
  }
};

final Map<String, FireError> fireAuthErrorMap = {
  'unknown-auth': FireError(
    title: 'Authentication error',
    text: 'Unknown authentication error',
  ),
  'user-not-found': FireError(
    title: 'User not found',
    text: 'The given user was not found on the server!',
  ),
  'weak-password': FireError(
    title: 'Weak password',
    text: 'Please choose a stronger password containing of more characters!',
  ),
  'invalid-email': FireError(
    title: 'Invalid email',
    text: 'Please double check your email and try again',
  ),
  'operation-not-allowed': FireError(
    title: 'Operation not allowed',
    text: 'You cannot register using this method at this moment',
  ),
  'email-already-in-use': FireError(
    title: 'Email already in use',
    text: 'Please choose another email to register with!',
  ),
  'requires-recent-login': FireError(
    title: 'Requires recent login',
    text: 'You need to log out and log back in again in order to perform this operation',
  ),
  'no-current-user': FireError(
    title: 'No current user!',
    text: 'No current user with this information was found',
  ),
  'account-exists-with-different-credential': FireError(
    title: 'Wrong Credentials',
    text: 'Account Exists with different credential',
  ),
  'invalid-credential': FireError(
    title: 'Invalid Credentials',
    text: 'Credential is malformed or has expired',
  ),
  'user-disabled': FireError(
    title: 'User disabled',
    text: 'User of given credential has been disabled',
  ),
  'invalid-verification-code': FireError(
    title: 'Invalid Verification Code',
    text: 'Verification code of the credential is not valid',
  ),
  'invalid-verification-id': FireError(
    title: 'Invalid Verification Id',
    text: 'Verification Id of the credential is not valid',
  ),
};

final Map<String, FireError> fireErrorMap = {
  //Core

  //Storage
  'storage/unknown': FireError(
    title: 'Error',
    text: 'Storage Unknown',
  ),
  'storage/object-not-found': FireError(
    title: 'Error',
    text: 'Storage Object not found',
  ),
  'storage/quota-exceeded': FireError(
    title: 'Error',
    text: 'Storage quota exceeded',
  ),
  'storage/unauthorized': FireError(
    title: 'Error',
    text: 'Storage unauthorized',
  ),
};
