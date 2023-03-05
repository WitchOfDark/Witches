// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart' show User, UserInfo;
import 'package:flutter/foundation.dart';

@immutable
class FireUser {
  final String id;
  final String? name;
  final String? email;
  final bool verified;
  final String? photoUrl;
  final List<UserInfo>? providerData;
  final String? idToken;
  final User? user;

  const FireUser({
    required this.id,
    this.name,
    required this.email,
    required this.verified,
    this.photoUrl,
    this.providerData,
    this.idToken,
    this.user,
  });

  factory FireUser.fire(User user) => FireUser(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        verified: user.emailVerified,
        photoUrl: user.photoURL,
        providerData: user.providerData,
        user: user,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'verified': verified,
      'photoUrl': photoUrl,
      'providerData': providerData?.map((x) => x.toString()).toList(),
      'idToken': idToken,
      'user': user,
    };
  }
}
