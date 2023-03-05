// ignore_for_file: public_member_api_docs, sort_constructors_first
library tamannaah;

import 'dart:async';

import 'package:tamannaah/darkknight/bloc_service.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:tamannaah/darkknight/extensions/build_context.dart';
import 'package:tamannaah/darkknight/utils.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tamannaah/services/settings/settings_bloc.dart';

import 'router/router.dart';
import 'router/special/error404.dart';
import 'services/bloc_creeper.dart';
import 'ui/rainbow.dart';

late final GoRouter globalRouter;

FutureOr<void> emptyFunction(
  List<BlocService> blocService,
  /*TamannaahNotifier tamannaahNotifier*/
) {
  return null;
}

Future<void> electrify({
  required final String appName,
  required List<BlocService> blocService,
  required bool creeper,
  required List<int> myHiveConstants,
  required List<Rainbow> myRainbows,
  required List<GoRoute> myRoutes,
  required List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  required List<Locale> supportedLocales,
  // required TamannaahNotifier tamannaahNotifier,
  required Color seedColor,
  FutureOr<void> Function(
    List<BlocService> blocService,
    /*TamannaahNotifier tamannaahNofier*/
  )
      init = emptyFunction,
}) async {
  runZonedGuarded<Future<void>>(
    () async {
      // debugPaintLayerBordersEnabled = true;
      // debugRepaintRainbowEnabled = true;

      WidgetsFlutterBinding.ensureInitialized();

      megaAppName = appName;

      lava("Tamannaah");

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);

      // await SystemChrome.setEnabledSystemUIMode(
      //   SystemUiMode.immersive,
      //   overlays: [
      //     SystemUiOverlay.bottom,
      //   ],
      // );

      ErrorWidget.builder = (FlutterErrorDetails details) {
        // If we're in debug mode, use the normal error widget which shows the error
        // message:
        // if (kDebugMode) {
        //   return ErrorWidget(details.exception);
        // }
        // In release builds, show a yellow-on-blue message instead:
        return SimpleError(details);
      };

      // This captures errors reported by the Flutter framework.
      FlutterError.onError = (FlutterErrorDetails details) async {
        final dynamic exception = details.exception;
        final StackTrace? stackTrace = details.stack;
        if (kDebugMode) {
          // In development mode simply print to console.
          FlutterError.dumpErrorToConsole(details);
        } else {
          // In production mode report to the application zone
          Zone.current.handleUncaughtError(exception, stackTrace!);
        }
      };

      if (creeper) {
        Bloc.observer = Creeper();
      }

      Grain(myRainbows);

      //---------------------------
      await init(
        blocService, /*tamannaahNotifier*/
      );
      for (var e in blocService) {
        await e.service?.init();
      }
      //---------------------------

      globalRouter = createRouter(myRoutes);

      // runApp(Preview(MyApp(blocService)));
      runApp(
        Tamannaah(
          blocService: blocService,
          seedColor: seedColor,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          // tamannaahNotifier: tamannaahNotifier,
        ),
      );
    },
    (error, stackTrace) async {
      if (kDebugMode) {
        // In development mode simply print to console.
        print('Caught Dart Error!');
        print('$error');
        print('$stackTrace');
      } else {
        // In production
        // Report errors to a reporting service such as Sentry or Crashlytics
        // exit(1); // you may exit the app
      }
    },
  );
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // PointerDeviceKind.trackpad,
      };
}

class Tamannaah extends StatelessWidget {
  const Tamannaah({
    required this.blocService,
    required this.seedColor,
    required this.localizationsDelegates,
    required this.supportedLocales,
    // required this.tamannaahNotifier,
    super.key,
  });

  final List<BlocService> blocService;
  final Color seedColor;
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final List<Locale> supportedLocales;
  // final TamannaahNotifier tamannaahNotifier;

  @override
  Widget build(BuildContext context) {
    // return MultiRepositoryProvider(
    //   providers: blocService.map((e) => e.serviceProvider()).toList(),
    //   child:

    // lava('Bloc empty : ${blocService.isEmpty} ${blocService.length}');

    assert(blocService.isNotEmpty);

    MyScrollBehavior? myScrollBehaviour = !Device.isMobile ? MyScrollBehavior() : null;

    return MultiBlocProvider(
      providers: blocService.map((e) => e.blocProvider()).toList(),
      // blocService.fold(
      // child: TamannaahInheritedNotifier(
      // tamannaahNotifier: tamannaahNotifier,
      child: ScreenUtilInit(
        designSize: const Size(360, 780),
        // minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return BlocBuilder<SettingsBloc, SettingsState>(
            // listener: (context, state) {},
            buildWhen: (previous, current) {
              lava(cast<SSettingsLoaded>(previous));
              owl(cast<SSettingsLoaded>(current));
              unicorn(cast<SSettingsLoaded>(previous) != cast<SSettingsLoaded>(current));
              return cast<SSettingsLoaded>(previous) != cast<SSettingsLoaded>(current);
            },
            builder: (context, state) {
              // TamannaahNotifier? tamannaahNotifier = TamannaahInheritedNotifier.of(context);
              // TSettings? settings = tamannaahNotifier?.data;

              TSettings? settings = cast<SSettingsLoaded>((state))?.settings;
              // dino(settings?.toMap().toString());

              SystemChrome.setSystemUIOverlayStyle(
                bows[settings?.theme ?? 0].dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
                // SystemUiOverlayStyle(
                //   statusBarColor: Colors.white,
                //   statusBarBrightness: Brightness.dark,
                // ),
              );

              // MediaQuery.of(context).platformBrightness;

              return MaterialApp.router(
                //
                title: megaAppName,

                themeMode: bows[settings?.theme ?? 0].dark ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData(
                  useMaterial3: true,
                  // textTheme: TextTheme(),
                  colorScheme: ColorScheme.fromSeed(
                    brightness: Brightness.light,
                    seedColor: seedColor,

                    // primary: Colors.blue,
                    // secondary: Colors.green,
                  ),
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  // textTheme: TextTheme(),
                  colorScheme: ColorScheme.fromSeed(
                    brightness: Brightness.dark,
                    seedColor: seedColor,
                  ),
                ),

                scrollBehavior: myScrollBehaviour,

                //Go_router
                routeInformationParser: globalRouter.routeInformationParser,
                routeInformationProvider: globalRouter.routeInformationProvider,
                routerDelegate: globalRouter.routerDelegate,

                //Device preview
                useInheritedMediaQuery: kDebugMode,

                //
                locale: settings?.locale != null ? Locale(settings!.locale!) : null,
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,

                // showSemanticsDebugger: true,
                // showPerformanceOverlay: true,
                debugShowCheckedModeBanner: kDebugMode,

                //
                builder: (context, child) {
                  initializeDateFormatting();

                  return child ?? const Text('No Main Widget');
                },
                // debugShowMaterialGrid: true,
              );
            },
          );
        },
        // ),
      ),
      //   (previousWidget, bloc) {
      //     final Widget h = bloc.blocConsumer == null
      //         ? previousWidget
      //         : bloc.blocConsumer!(
      //             (context) => previousWidget,
      //           );
      //     lava('${bloc.blocConsumer} : $previousWidget : $h');
      //     return h;
      //   },
      // );
    );
  }
}

// class TamannaahNotifier extends ChangeNotifier {
//   TSettings _data;

//   TamannaahNotifier({
//     required TSettings data,
//   }) : _data = data;

//   TSettings get data => _data;

//   set data(TSettings newData) {
//     if (newData != _data) {
//       _data = newData;
//       notifyListeners();
//     }
//   }
// }

// class TamannaahInheritedNotifier extends InheritedNotifier<TamannaahNotifier> {
//   const TamannaahInheritedNotifier({
//     super.key,
//     required TamannaahNotifier tamannaahNotifier,
//     required super.child,
//   }) : super(notifier: tamannaahNotifier);

//   static TamannaahNotifier? of(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<TamannaahInheritedNotifier>()?.notifier;
// }
