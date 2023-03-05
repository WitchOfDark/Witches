import 'dart:convert';

import 'package:tamannaah/darkknight/debug_functions.dart';

enum Role {
  gamer,
  customer,
}

class Permission {
  static String upload = "upload.attachments";
  static String edit = "edit.user.message";
  static String delete = "delete.user.message";
}

class Auth0IdToken {
  Auth0IdToken({
    required this.nickname,
    required this.name,
    required this.picture,
    required this.updatedAt,
    required this.email,
    required this.emailVerified,
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    this.sid,
    this.nonce,
    required this.streamUserToken,
    required this.roles,
    required this.permissions,
  });

  final String nickname;
  final String name;
  final String picture;
  final DateTime updatedAt;
  final String email;
  final bool emailVerified;
  final String iss;

  final String sub;
  String get userId => sub;

  final String aud;
  final int iat;
  final int exp;
  final String? sid;
  final String? nonce;

  final String streamUserToken;

  get isCustomer => roles.where((r) => r == Role.customer).isNotEmpty;
  get isGamer => roles.where((r) => r == Role.gamer).isNotEmpty;
  final List<Role> roles;

  bool can(String permission) => permissions.where((p) => p == permission).isNotEmpty;
  final List<String> permissions;

  factory Auth0IdToken.fromRawJson(String str) => Auth0IdToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Auth0IdToken.fromJson(Map<String, dynamic> json) => Auth0IdToken(
        nickname: json["nickname"],
        name: json["name"],
        picture: json["picture"],
        updatedAt: DateTime.parse(json["updated_at"]),
        email: json["email"],
        emailVerified: json["email_verified"],
        iss: json["iss"],
        sub: json["sub"],
        aud: json["aud"],
        iat: json["iat"],
        exp: json["exp"],
        sid: json["sid"],
        nonce: json["nonce"],
        streamUserToken: json["https://getstream.marvel.app/user_token"],
        roles: List<Role>.from(json["https://users.marvel.app/roles"].map((x) {
          if (x["name"] == "Gamer") {
            return Role.gamer;
          } else if (x["name"] == "Customer") {
            return Role.customer;
          }
        })),
        permissions: List<String>.from(json["https://users.marvel.app/permissions"].map((x) => x["permission_name"])),
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
        "picture": picture,
        "updated_at": updatedAt.toIso8601String(),
        "email": email,
        "email_verified": emailVerified,
        "iss": iss,
        "sub": sub,
        "aud": aud,
        "iat": iat,
        "exp": exp,
        "sid": sid,
        "nonce": nonce,
        "streamUserToken": streamUserToken,
        "roles": roles.toString(),
        "permissions": permissions,
      };
}

Auth0IdToken parseIdToken(String idToken) {
  final parts = idToken.split('.');

  final Map<String, dynamic> json = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

  dino(json);
  unicorn(Auth0IdToken.fromJson(json));

  return Auth0IdToken.fromJson(json);
}

class Auth0User {
  Auth0User({
    required this.sub,
    required this.nickname,
    required this.name,
    required this.picture,
    required this.updatedAt,
    required this.email,
    required this.emailVerified,
    required this.streamUserToken,
    required this.roles,
    required this.permissions,
  });

  final String sub;
  String get userId => sub.split('|').join('');

  final String nickname;
  final String name;
  final String picture;
  final DateTime updatedAt;
  final String email;
  final bool emailVerified;

  final String streamUserToken;

  get isCustomer => roles.where((r) => r == Role.customer).isNotEmpty;
  get isGamer => roles.where((r) => r == Role.gamer).isNotEmpty;
  final List<Role> roles;

  bool can(String permission) => permissions.where((p) => p == permission).isNotEmpty;
  final List<String> permissions;

  factory Auth0User.fromRawJson(String str) => Auth0User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Auth0User.fromJson(Map<String, dynamic> json) => Auth0User(
        sub: json["sub"],
        nickname: json["nickname"],
        name: json["name"],
        picture: json["picture"],
        updatedAt: DateTime.parse(json["updated_at"]),
        email: json["email"],
        emailVerified: json["email_verified"],
        streamUserToken: json["https://getstream.marvel.app/user_token"],
        roles: List<Role>.from(json["https://users.marvel.app/roles"].map((x) {
          if (x["name"] == "Gamer") {
            return Role.gamer;
          } else if (x["name"] == "Customer") {
            return Role.customer;
          }
        })),
        permissions: List<String>.from(json["https://users.marvel.app/permissions"].map((x) => x["permission_name"])),
      );

  Map<String, dynamic> toJson() => {
        "sub": sub,
        "nickname": nickname,
        "name": name,
        "picture": picture,
        "updated_at": updatedAt.toIso8601String(),
        "email": email,
        "email_verified": emailVerified,
        "streamUserToken": streamUserToken,
        "roles": roles.toString(),
        "permissions": permissions,
      };
}
