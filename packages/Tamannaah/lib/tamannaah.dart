library tamannaah;

export 'services/bloc_service.dart';

//---------------------------------------------------------

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
// import 'package:isar/isar.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'router/special/error404.dart';
import 'services/fire_auth/fire_service.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/router.dart';
import 'services/fire_auth/providers/fire_provider.dart';
import 'tools/extensions/build_context.dart';
import 'tools/utils.dart';
import 'ui/rainbow.dart';

import 'services/bloc_creeper.dart';
import 'services/bloc_service.dart';
import 'services/hive_constants.dart';
import 'services/api/api_bloc.dart';
import 'services/api/api_service.dart';
import 'services/settings/settings_bloc.dart';
import 'services/settings/settings_service.dart';

import 'tools/debug_functions.dart';

late final GoRouter globalRouter;

void emptyFunction() {}

Future<void> tamannaahInit({
  required final String appName,
  required List<BlocService> blocService,
  FirebaseOptions? fireOptions,
  List<FireMoon> fireMoons = const [],
  required bool creeper,
  required List<int> myHiveConstants,
  required List<Rainbow> myRainbows,
  required List<GoRoute> myRoutes,
  FireProvider? customAuthProvider,
  required List<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  required List<Locale> supportedLocales,
  void Function() init = emptyFunction,
}) async {
  runZonedGuarded<Future<void>>(
    () async {
      // debugPaintLayerBordersEnabled = true;
      // debugRepaintRainbowEnabled = true;

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

      megaAppName = appName;

      lava("TamannaahInit");

      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);

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

      if (kDebugMode) {
        for (var e in myHiveConstants) {
          if (globalHiveConstants.contains(e)) {
            throw Exception("Same constant on two hiveModels");
          }
        }
      }

      Grain(myRainbows);

      if (!Device.isWeb) {
        lava(await getApplicationSupportDirectory());
        Hive.init((await getApplicationSupportDirectory()).path);
      }

      ApiService apiService = ApiService();
      SettingsService settingsService = SettingsService();

      // IsarApiService isarApiService = IsarApiService()..init();

      FireService fireService = FireService();
      await fireService.fireBloc(
        blocService: blocService,
        fireOptions: fireOptions,
        fireMoons: fireMoons,
        customAuthProvider: customAuthProvider,
      );

      blocService.addAll([
        BlocService(
          service: settingsService,
          // serviceProvider: () {
          //   return RepositoryProvider<SettingsService>(
          //     create: (context) => settingsService,
          //   );
          // },
          blocProvider: () {
            return BlocProvider<SettingsBloc>(
              create: (context) => SettingsBloc(settingsService)..add(ESettingsLoad()),
            );
          },
        ),
        BlocService(
          service: apiService,
          // serviceProvider: () {
          //   return RepositoryProvider<ApiService>(
          //     create: (context) => apiService,
          //   );
          // },
          blocProvider: () {
            return BlocProvider<ApiBloc>(
              create: (context) => ApiBloc(apiService),
            );
          },
        ),
        // BlocService(
        //   service: null,
        //   blocProvider: () {
        //     return BlocProvider<BerryBloc>(
        //       create: (context) => BerryBloc(),
        //     );
        //   },
        // ),
      ]);

      // final isar = await Isar.open(
      //   [
      //     IsarApiSchema,
      //   ],
      //   directory: (await getApplicationSupportDirectory()).path,
      // );

      for (var e in blocService) {
        await e.service?.init();
      }

      globalRouter = createRouter(myRoutes, fireMoons.isNotEmpty);

      init();

      // runApp(Preview(MyApp(blocService)));
      runApp(
        Tamannaah(
          blocService: blocService,
          seedColor: Colors.black,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
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

class Tamannaah extends StatelessWidget {
  const Tamannaah({
    required this.blocService,
    required this.seedColor,
    required this.localizationsDelegates,
    required this.supportedLocales,
    super.key,
  });

  final List<BlocService> blocService;
  final Color seedColor;
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final List<Locale> supportedLocales;

  @override
  Widget build(BuildContext context) {
    if (blocService.isEmpty) {
      throw (Exception("No bloc found"));
    }

    // return MultiRepositoryProvider(
    //   providers: blocService.map((e) => e.serviceProvider()).toList(),
    //   child:

    // dino('--------------------------------Material App');
    // megaAllLocales = supportedLocales;

    return MultiBlocProvider(
      providers: blocService.map((e) => e.blocProvider()).toList(),
      child: ScreenUtilInit(
        designSize: const Size(360, 780),
        // minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return BlocConsumer<SettingsBloc, SettingsState>(
            listener: (context, state) {},
            builder: (context, state) {
              dino('Settings bloc');
              SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
              Settings? settings = cast<SSettingsLoaded>((bloc.state))?.settings;
              return MaterialApp.router(
                //
                title: megaAppName,

                themeMode: ThemeMode.light,
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

                //Go_router
                routeInformationParser: globalRouter.routeInformationParser,
                routeInformationProvider: globalRouter.routeInformationProvider,
                routerDelegate: globalRouter.routerDelegate,

                //Device preview
                useInheritedMediaQuery: true,

                //
                // locale: megaLocale,
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,

                // showSemanticsDebugger: true,
                // showPerformanceOverlay: true,
                debugShowCheckedModeBanner: false,

                //
                builder: (context, widget) {
                  lava('Main Widget');
                  initializeDateFormatting();
                  return widget ?? const Text('No Main Widget');
                },
                // debugShowMaterialGrid: true,
              );
            },
          );
        },
      ),
      // ),
    );
  }
}
