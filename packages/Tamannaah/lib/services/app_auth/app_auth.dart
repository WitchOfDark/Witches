// // ignore_for_file: constant_identifier_names

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// import '../services/auth/app_auth_service.dart';
// import '../tools/debug_functions.dart';

// const AUTH0_DOMAIN =
//     "dev-lclzl18m.us.auth0.com"; //String.fromEnvironment("AUTH0_DOMAIN");
// const AUTH0_CLIENT_ID =
//     "M9koAzFYaJgnoCKRgnUo56SUtlHWrVJr"; //String.fromEnvironment("AUTH0_CLIENT_ID");
// const AUTH0_ISSUER = "https://$AUTH0_DOMAIN";
// const BUNDLE_IDENTIFIER = "io.dracula.marvel";
// const AUTH0_REDIRECT_URI = "$BUNDLE_IDENTIFIER://login-callback";

// //"https://$AUTH0_DOMAIN/.well-known/openid-configuration"

// const REFRESH_TOKEN_KEY = "refresh-token";

// //Instantiate
// const appAuth = FlutterAppAuth();
// const secureStorage = FlutterSecureStorage();

// //Init
// Future<String> init() async {
//   return errorHandler(
//     () async {
//       final securedRefreshToken =
//           await secureStorage.read(key: REFRESH_TOKEN_KEY);

//       unicorn(securedRefreshToken);

//       if (securedRefreshToken == null) {
//         return 'You need to login';
//       }

//       final response = await appAuth.token(
//         TokenRequest(
//           AUTH0_CLIENT_ID,
//           AUTH0_REDIRECT_URI,
//           issuer: AUTH0_ISSUER,
//           refreshToken: securedRefreshToken,
//         ),
//       );

//       final result = await _setLocalVariables(response);

//       return result;
//     },
//   );
// }

// //login

// bool isAuthResultValid(TokenResponse? res) {
//   return res?.idToken != null && res?.accessToken != null;
// }

// String? accessToken;
// Auth0IdToken? idToken;
// Auth0User? profile;

// Future<String> _setLocalVariables(TokenResponse? res) async {
//   if (isAuthResultValid(res)) {
//     accessToken = res!.accessToken!;
//     idToken = parseIdToken(res.idToken!);
//     profile = await getUserDetails(accessToken!);

//     if (res.refreshToken != null) {
//       await secureStorage.write(
//         key: REFRESH_TOKEN_KEY,
//         value: res.refreshToken,
//       );
//     }

//     return 'Success';
//   }
//   return 'Passing token went wrong';
// }

// Future<Auth0User> getUserDetails(String accessToken) async {
//   final url = Uri.https(AUTH0_DOMAIN, '/userinfo');

//   final response = await Dio().getUri(
//     url,
//     options: Options(
//       headers: {
//         'Authorization': 'Bearer $accessToken',
//       },
//     ),
//   );

//   if (response.statusCode == 200) {
//     dino(response.data);
//     unicorn(Auth0User.fromJson(response.data).toJson());

//     return Auth0User.fromJson(response.data);
//   } else {
//     throw const UserInfoException('Failed to get user details');
//   }
// }

// class UserInfoException implements Exception {
//   const UserInfoException(this.message);
//   final String message;
// }

// typedef AsyncCallBackString = Future<String> Function();

// Future<String> errorHandler(AsyncCallBackString callback) async {
//   try {
//     return await callback();
//   } on TimeoutException catch (e, t) {
//     lava(e);
//     lava(t);
//     return e.message ?? 'Timeout Error!';
//   } on FormatException catch (e, t) {
//     lava(e);
//     lava(t);
//     return e.message;
//   } on SocketException catch (e, t) {
//     lava(e);
//     lava(t);
//     return e.message;
//   } on PlatformException catch (e, t) {
//     lava(e);
//     lava(t);
//     return e.message ?? 'Platform exception : ${e.code}';
//   } on UserInfoException catch (e, t) {
//     lava(e);
//     lava(t);
//     return e.message;
//   } catch (e, t) {
//     lava(e);
//     lava(t);
//     return 'Unknown error ${e.runtimeType}';
//   }
// }

// Future<String> login() async {
//   return errorHandler(() async {
//     final authTokenReq = AuthorizationTokenRequest(
//       AUTH0_CLIENT_ID,
//       AUTH0_REDIRECT_URI,
//       issuer: AUTH0_ISSUER,
//       scopes: [
//         'openid',
//         'profile',
//         'email',
//         'offline_access',
//       ],
//       promptValues: ['login'],
//     );

//     final res = await appAuth.authorizeAndExchangeCode(authTokenReq);

//     return _setLocalVariables(res);

//     // dino({
//     //   "accessToken": result?.accessToken,
//     //   "refreshToken": result?.refreshToken,
//     //   "scopes": result?.scopes,
//     //   "idToken": result?.idToken,
//     //   "tokenType": result?.tokenType,
//     // });
//   });
// }

// Future<void> logout() async {
//   await secureStorage.delete(key: REFRESH_TOKEN_KEY);
//   //--------------------------------------------------------
//   //              Logout endpoint
//   // final url = Uri.https(
//   //   AUTH0_DOMAIN,
//   //   '/v2/logout',
//   //   {
//   //     'client_id': AUTH0_CLIENT_ID,
//   //     'federated': '',
//   //     'returnTo': 'marvel://io.dracula.marvel/',
//   //   },
//   // );

//   // unicorn(url.toString());

//   // final res = await http.get(url, headers: {
//   //   'Authorization': 'Bearer $accessToken',
//   // });

//   // lava(res.body);
//   // unicorn(res.statusCode);
//   // lava(res.request);
//   // lava(res.isRedirect);

//   // final response = await Dio().getUri(
//   //   url,
//   //   options: Options(
//   //     headers: {
//   //       'Authorization': 'Bearer $accessToken',
//   //     },
//   //   ),
//   // );
//   // lava(response);
//   // lava(response.data);
//   // lava(response.data.toString());
//   // lava(response.toString());
//   //--------------------------------------------------------
//   //              EndSession Request
//   // if (idToken != null) {
//   //   unicorn("Hello");
//   //   final request = EndSessionRequest(
//   //     idTokenHint: jsonEncode(idToken!.toJson()),
//   //     issuer: AUTH0_ISSUER,
//   //     // postLogoutRedirectUrl: '$BUNDLE_IDENTIFIER:/',
//   //     // postLogoutRedirectUrl: '$BUNDLE_IDENTIFIER://',
//   //     // postLogoutRedirectUrl: 'https://$BUNDLE_IDENTIFIER/',
//   //     // postLogoutRedirectUrl: 'marvel://$BUNDLE_IDENTIFIER/',
//   //     // postLogoutRedirectUrl: 'https://localhost',
//   //     // postLogoutRedirectUrl: 'marvel:/',
//   //   );
//   //   lava(request);
//   //   try {
//   //     runZonedGuarded<Future<void>>(
//   //       () async {
//   //         final response = await appAuth.endSession(request);
//   //         dino(response.toString());
//   //       },
//   //       (error, stackTrace) async {
//   //         lava('Caught Dart Error!');
//   //         dino('$error');
//   //         unicorn('$stackTrace');
//   //       },
//   //     );

//   //     // lava(response?.state);
//   //   } catch (e, t) {
//   //     lava(e);
//   //     lava(t);
//   //   }
//   //   unicorn("logout");
//   // }
//   //--------------------------------------------------------
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   Channel? _channel;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: _channel != null
//               ? StreamChat(
//                   client: client,
//                   child: Scaffold(
//                     body: StreamChannel(
//                       channel: _channel!,
//                       child: Column(
//                         children: [
//                           const Expanded(child: StreamMessageListView()),
//                           StreamMessageInput(
//                             disableAttachments:
//                                 !profile!.can(Permission.upload),
//                             sendButtonLocation: SendButtonLocation.inside,
//                             actionsLocation: ActionsLocation.leftInside,
//                             showCommandsButton: true,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       FutureBuilder(
//                         future: secureStorage.readAll(),
//                         builder: ((context, snapshot) {
//                           return Text(beautifyMap(snapshot.data));
//                         }),
//                       ),
//                       OutlinedButton(
//                         onPressed: () {
//                           final scaffoldMessengerState =
//                               ScaffoldMessenger.of(context);
//                           () async {
//                             final result = await init();

//                             if (result != 'Success') {
//                               final snackbar = SnackBar(content: Text(result));
//                               scaffoldMessengerState.showSnackBar(snackbar);
//                             }

//                             if (result == 'Success') {
//                               await connectUser(profile!);
//                               lava(profile!.toJson());
//                             }

//                             setState(() {});
//                           }();
//                         },
//                         child: const Text("Init"),
//                       ),
//                       OutlinedButton(
//                         onPressed: () {
//                           final scaffoldMessengerState =
//                               ScaffoldMessenger.of(context);
//                           () async {
//                             final result = await login();

//                             if (result != 'Success') {
//                               final snackbar = SnackBar(content: Text(result));
//                               scaffoldMessengerState.showSnackBar(snackbar);
//                             }

//                             if (result == 'Success') {
//                               await connectUser(profile!);
//                               lava(profile!.toJson());
//                             }
//                             setState(() {});
//                           }();
//                         },
//                         child: const Text("Login"),
//                       ),
//                       OutlinedButton(
//                         onPressed: () async {
//                           await logout();
//                           setState(() {});
//                         },
//                         child: const Text("Logout"),
//                       ),
//                       OutlinedButton(
//                         onPressed: () async {
//                           await getUserDetails(accessToken!);
//                           setState(() {});
//                         },
//                         child: const Text("Userdetails"),
//                       ),
//                       OutlinedButton(
//                         onPressed: () async {
//                           _channel = await createSupportChat();
//                           setState(() {});
//                         },
//                         child: const Text("StreamChat"),
//                       ),
//                       // Text(beautifyMap(profile?.toJson()) ?? "profile"),
//                       // const Text('---------------------------------'),
//                       // Text('AccessToken : $accessToken'),
//                       // const Text('---------------------------------'),
//                       // Text(beautifyMap(idToken?.toJson()) ?? 'idToken'),
//                       // const Text('---------------------------------'),
//                       // const Text('Domain $AUTH0_DOMAIN'),
//                       // const Text('---------------------------------'),
//                       // const Text('ClientId $AUTH0_CLIENT_ID'),
//                       // const Text('---------------------------------'),
//                       // const Text('BundleId $BUNDLE_IDENTIFIER'),
//                       // const Text('---------------------------------'),
//                       // const Text('Redirect $AUTH0_REDIRECT_URI'),
//                       // const Text('---------------------------------'),
//                       // const Text('Issuer $AUTH0_ISSUER'),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

// //-------------------------------------------------------------
// //-------------------------------------------------------------
// //-------------------------------------------------------------
// //                          Stream Chat
// //-------------------------------------------------------------
// //-------------------------------------------------------------
// //-------------------------------------------------------------

// const STREAM_API_KEY = 'hhtp6cas79qd';

// final client = StreamChatClient(
//   STREAM_API_KEY,
//   logLevel: kDebugMode ? Level.INFO : Level.OFF,
// );

// Future<Auth0User> connectUser(Auth0User user) async {
//   unicorn('UserId : ${user.userId}');

//   final result = await client.connectUser(
//     User(
//       id: user.userId,
//       extraData: {
//         'image': user.picture,
//         'name': user.name,
//       },
//     ),
//     //Replaced with production token in prod env
//     // client.devToken(user.userId).rawValue,
//     user.streamUserToken,
//   );

//   unicorn(result.toJson());
//   return user;
// }

// String? currentChannelId;

// Future<Channel> createSupportChat() async {
//   const employeeId = 'qadiko';
//   final channel = client.channel(
//     'support',
//     extraData: {
//       'name': 'Coffee Support',
//       'members': [
//         employeeId,
//         client.state.currentUser!.id,
//       ],
//     },
//   );
//   await channel.watch();
//   currentChannelId = channel.id;
//   return channel;
// }
