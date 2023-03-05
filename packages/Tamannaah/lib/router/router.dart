import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:darkknight/debug_functions.dart';

import 'special/error404.dart';

late final String megaAppName;

final GlobalKey<NavigatorState> megaNavKey = GlobalKey<NavigatorState>(debugLabel: 'MegaNavKey');

String? Function(GoRouterState state) routeChecker = (state) {
  return null;
};

Stream<dynamic>? routeStream;

GoRouter createRouter(List<GoRoute> routes) {
  usePathUrlStrategy();

  return GoRouter(
    initialLocation: '/',
    routes: routes,
    //
    // observers: <NavigatorObserver>[MyNavObserver()],

    debugLogDiagnostics: true,
    navigatorKey: megaNavKey,
    //
    redirect: (context, state) {
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
      return routeChecker(state);
    },
    //////// refreshListenable: BlocProvider.of<FireAuthBloc>(context),
    refreshListenable: routeStream != null ? GoRouterRefreshStream(routeStream!) : null,
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
  MyNavObserver();

  /// The logged message.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      owl('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      owl('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      owl('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      owl('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      owl('didStartUserGesture: ${route.str}, '
          'previousRoute= ${previousRoute?.str}');

  @override
  void didStopUserGesture() => owl('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
