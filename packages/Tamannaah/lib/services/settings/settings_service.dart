import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

import '../../tools/debug_functions.dart';
import '../bloc_service.dart';
import '../hive_constants.dart';

part 'settings_service.g.dart';

@HiveType(typeId: settingsBoxNum)
class Settings extends HiveObject implements DbHelp {
  @HiveField(0)
  final int theme;
  @HiveField(1)
  final int lastAppOpen;

  Settings({
    required this.theme,
    required this.lastAppOpen,
  });

  Settings copyWith({
    int? theme,
    int? lastAppOpen,
  }) {
    return Settings(
      theme: theme ?? this.theme,
      lastAppOpen: lastAppOpen ?? this.lastAppOpen,
    );
  }

  @override
  Widget toWidget() {
    return Column(
      children: [
        Text("Theme : $theme"),
        Text("Last Open : $lastAppOpen"),
      ],
    );
  }

  @override
  Map<String, Map> toMap() {
    return {
      "Settings": {
        'theme': theme,
        'lastAppOpen': lastAppOpen,
      }
    };
  }
}

class SettingsService implements DbService {
  @override
  bool initialized = false;

  late Box<Settings> _settingsBox;

  @override
  Box<Settings> get pbox {
    return _settingsBox;
  }

  @override
  IsarCollection<DbHelp>? get ibox {
    return null;
  }

  final String _settingsKey = "Settings";

  final HashMap<String, Settings> _settingsMap = HashMap<String, Settings>();

  @override
  HashMap<String, Settings> get pmap {
    return _settingsMap;
  }

  @override
  Future<void> init() async {
    if (!initialized) {
      Hive.registerAdapter(SettingsAdapter());
      _settingsBox = await Hive.openBox<Settings>(settingsBoxName);

      int time = DateTime.now().millisecondsSinceEpoch;

      Settings s = _settingsBox.get(_settingsKey)?.copyWith(lastAppOpen: time) ??
          Settings(theme: 17, lastAppOpen: time);

      await updateSettings(s);

      // await _api.clear();
    }
    initialized = true;
    dino("SettingsService initialized");
  }

  //updateSettings : update on memory and disk
  Future<Settings> updateSettings(Settings s) async {
    _settingsMap.update(_settingsKey, (value) => s, ifAbsent: () => s);
    await _settingsBox.put(_settingsKey, s);
    return s;
  }

  Future<Settings> loadSettings() async {
    // lava(bows[_settingsMap[_settingsKey]!.theme]);
    return _settingsMap[_settingsKey]!;
  }
}
