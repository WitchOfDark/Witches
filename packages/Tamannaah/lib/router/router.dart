import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:logging/logging.dart';

import '../services/fire_auth/fire_service.dart';
import '../services/hive_viewer.dart';
import '../tools/debug_functions.dart';

import 'special/error404.dart';
import 'auth/login.dart';
import 'special/settings.dart';

late final String megaAppName;
// late final List<Locale> megaAllLocales;
// Locale? megaLocale;

const String //
    hiveviewer = 'hiveviewer',
    settings = 'settings',
    login = 'login';

final List<GoRoute> _routes = [
  //hiveviewer
  GoRoute(
    name: hiveviewer,
    path: '/$hiveviewer',
    pageBuilder: ((context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: HiveViewer(hiveViewerInit([])),
      );
    }),
  ),
  // settings
  GoRoute(
    name: settings,
    path: '/$settings',
    pageBuilder: ((context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: const SettingsPage(),
      );
    }),
  ),
  // login
  GoRoute(
    name: login,
    path: '/$login',
    pageBuilder: ((context, state) {
      return MaterialPage(
        key: state.pageKey,
        //LoginPage(from : state.queryParams['from'])
        child: const LoginPage(),
      );
    }),
  ),
];

final GlobalKey<NavigatorState> megaNavKey = GlobalKey<NavigatorState>(debugLabel: 'MegaNavKey');

GoRouter createRouter(List<GoRoute> routes, bool checkFire) {
  usePathUrlStrategy();

  _routes.addAll(routes);

  return GoRouter(
    initialLocation: '/',
    routes: _routes,
    //
    // observers: <NavigatorObserver>[MyNavObserver()],

    debugLogDiagnostics: true,
    navigatorKey: megaNavKey,
    //
    redirect: !checkFire
        ? (context, state) => null
        : (context, state) {
            final loggedIn = FireService.user != null;
            final isLogging = state.subloc == '/$login';

            if (!loggedIn & !isLogging) return '/$login';
            if (loggedIn && isLogging) return '/';

            // unicorn({
            //   'location': state.location,
            //   'subloc': state.subloc,
            //   'fullpath': state.fullpath,
            //   'name': state.name,
            //   'params': state.params,
            //   'path': state.path,
            //   'queryParams': state.queryParams,
            //   'queryParamsAll': state.queryParametersAll,
            //   'error': state.error.toString()
            // });

            //////////////////////// return '/$login?from=${state.subloc}';
            return null;
          },
    //////// refreshListenable: BlocProvider.of<FireAuthBloc>(context),
    refreshListenable: checkFire ? GoRouterRefreshStream(FireService.status) : null,
    //
    errorPageBuilder: ((context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Error404(
            error: {
          'location': state.location,
          'subloc': state.subloc,
          'fullpath': state.fullpath,
          'name': state.name,
          'params': state.params,
          'path': state.path,
          'queryParams': state.queryParams,
          'queryParamsAll': state.queryParametersAll,
          'error': state.error.toString(),
        }.toString()),
      );
    }),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// The Navigator observer.
class MyNavObserver extends NavigatorObserver {
  /// Creates a [MyNavObserver].
  MyNavObserver() {
    log.onRecord.listen((LogRecord e) => debugPrint('$e'));
  }

  /// The logged message.
  final Logger log = Logger('MyNavObserver');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.info('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.info('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.info('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      log.info('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      log.info('didStartUserGesture: ${route.str}, '
          'previousRoute= ${previousRoute?.str}');

  @override
  void didStopUserGesture() => log.info('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${this.settings.name}: ${this.settings.arguments})';
}
