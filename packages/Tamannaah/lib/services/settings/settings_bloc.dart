// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:darkknight/bloc_service.dart';
import 'package:darkknight/debug_functions.dart';
import 'package:darkknight/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamannaah/ui/rainbow.dart';

// import '../../tamannaah.dart';

abstract class SettingsService implements Service {
  Future<TSettings> updateSettings(TSettings s);
  Future<TSettings> loadSettings();
}

class TSettings with EquatableMixin {
  final int theme;
  final int lastAppOpen;
  final String? locale;
  final List<String> supportedLocales;

  TSettings({
    this.theme = 0,
    required this.lastAppOpen,
    this.locale,
    this.supportedLocales = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'theme': theme,
      'lastAppOpen': lastAppOpen,
      'locale': locale,
      'supportedLocales': supportedLocales,
    };
  }

  static TSettings fromMap(Map<String, dynamic> map) {
    lava(map);
    return TSettings(
      theme: cast<int>(map['theme']) ?? 0,
      lastAppOpen: cast<int>(map['lastAppOpen']) ?? DateTime.now().millisecondsSinceEpoch,
      locale: cast<String>(map['locale']),
      supportedLocales: cast<List<String>>(map['supportedLocales']) ?? <String>['es', 'au'],
    );
  }

  TSettings copyWith({
    int? theme,
    int? lastAppOpen,
    String? locale,
    List<String>? supportedLocales,
  }) {
    return TSettings(
      theme: theme ?? this.theme,
      lastAppOpen: lastAppOpen ?? this.lastAppOpen,
      locale: locale ?? this.locale,
      supportedLocales: supportedLocales ?? this.supportedLocales,
    );
  }

  @override
  List<Object?> get props => [theme, locale, supportedLocales];
}

//
//
//          State
//
//
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SSettingsInitial extends SettingsState {}

class SSettingsLoaded extends SettingsState {
  final TSettings settings;

  const SSettingsLoaded(this.settings);

  @override
  List<Object> get props => [settings];
}

//
//
//          Event
//
//
abstract class SettingsEvent extends Equatable implements ToMap {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ESettingsLoad extends SettingsEvent {
  @override
  List<Object> get props => [];

  @override
  Map<String, Map> toMap() {
    return {};
  }
}

class ESettingsUpdate extends SettingsEvent {
  final TSettings settings;
  // final TamannaahNotifier? notifier;

  const ESettingsUpdate({
    required this.settings,
    /* required this.notifier*/
  });

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toMap() {
    return settings.toMap();
  }
}

//
//
//          Bloc
//
//
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;

  static SettingsBloc pro(BuildContext context) {
    return BlocProvider.of<SettingsBloc>(context);
  }

  SettingsBloc(this._settingsService) : super(SSettingsInitial()) {
    //Events
    on<ESettingsLoad>((event, emit) async {
      TSettings settings = await _settingsService.loadSettings();
      Grain.oneRainbow = settings.theme;
      emit(SSettingsLoaded(settings));
    });

    on<ESettingsUpdate>((event, emit) async {
      TSettings settings = await _settingsService.updateSettings(event.settings);
      Grain.oneRainbow = settings.theme;
      // event.notifier?.data = settings;
      emit(SSettingsLoaded(settings));
    });
  }
}

BlocService settingsBlocService(SettingsService service) {
  SettingsService settingsService = service;

  return BlocService(
    service: settingsService,
    // serviceProvider: () {
    //   return RepositoryProvider<SettingsService>(
    //     create: (context) => settingsService,
    //   );
    // },
    blocProvider: () {
      return BlocProvider<SettingsBloc>(
        // lazy: false,
        create: (context) => SettingsBloc(settingsService)..add(ESettingsLoad()),
      );
    },

    // blocConsumer: (child) {
    //   return BlocConsumer<SettingsBloc, SettingsState>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       Settings? settings = cast<SSettingsLoaded>((state))?.settings;
    //       dino(settings?.toMap().toString());
    //       return child(context);
    //     },
    //   );
    // },
  );
}
