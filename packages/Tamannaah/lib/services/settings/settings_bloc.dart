import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../services/bloc_service.dart';

import '../../ui/rainbow.dart';
import 'settings_service.dart';

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
  final Settings settings;

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
  final Settings settings;

  const ESettingsUpdate(this.settings);

  @override
  List<Object> get props => [];

  @override
  Map<String, Map> toMap() {
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

  SettingsBloc(this._settingsService) : super(SSettingsInitial()) {
    //Events
    on<ESettingsLoad>((event, emit) async {
      Settings settings = await _settingsService.loadSettings();
      Grain.oneRainbow = settings.theme;
      emit(SSettingsLoaded(settings));
    });

    on<ESettingsUpdate>((event, emit) async {
      Settings settings = await _settingsService.updateSettings(event.settings);
      Grain.oneRainbow = settings.theme;
      emit(SSettingsLoaded(settings));
    });
  }
}
