// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:darkknight/debug_functions.dart';
import 'package:darkknight/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:miner/db_helper.dart';
import 'package:tamannaah/services/settings/settings_bloc.dart';
import 'package:tamannaah/ui/rainbow.dart';

import '../hive_constants.dart';

part 'settings_service.g.dart';

@HiveType(typeId: settingsBoxNum)
class Settings extends HiveObject implements DbHelp {
  @HiveField(0)
  final Map<String, dynamic> data;

  Settings({
    required this.data,
  });

  @override
  Widget toWidget() {
    return Column(
      children: [
        Text("Theme : ${beautifyMap(data)}"),
      ],
    );
  }

  @override
  Map<String, Map> toMap() {
    return {"Settings": data};
  }

  Settings copyWith({
    Map<String, dynamic>? data,
  }) {
    return Settings(
      data: data ?? this.data,
    );
  }
}

Settings toHive(TSettings t) => Settings(data: t.toMap());
TSettings fromHive(Settings t) => TSettings.fromMap(t.data);

class HiveSettingsService implements HDbSettingsService {
  @override
  bool initialized = false;

  late Box<Settings> _settingsBox;

  @override
  Box<Settings> get pbox {
    return _settingsBox;
  }

  final String _settingsKey = "Settings";

  final HashMap<String, Settings> _settingsMap = HashMap<String, Settings>();

  @override
  HashMap<String, Settings> get pmap {
    return _settingsMap;
  }

  @override
  Future<TSettings?> init([dynamic tSetData]) async {
    if (!initialized) {
      Hive.registerAdapter(SettingsAdapter());
      _settingsBox = await Hive.openBox<Settings>(settingsBoxName);

      TSettings? currentSet = cast<TSettings>(tSetData);
      Settings s = _settingsBox.get(_settingsKey) ?? Settings(data: {});
      TSettings tset = fromHive(s).copyWith(
        lastAppOpen: currentSet?.lastAppOpen ?? DateTime.now().millisecondsSinceEpoch,
        supportedLocales: currentSet?.supportedLocales,
      );

      s = s.copyWith(data: tset.toMap());

      Grain.oneRainbow = tset.theme;

      await updateSettings(fromHive(s));

      initialized = true;
      dino("SettingsService initialized");

      return fromHive(s);
      // await _api.clear();
    }

    return null;
  }

  //updateSettings : update on memory and disk
  @override
  Future<TSettings> updateSettings(TSettings s) async {
    _settingsMap.update(_settingsKey, (value) => toHive(s), ifAbsent: () => toHive(s));
    await _settingsBox.put(_settingsKey, toHive(s));
    return s;
  }

  @override
  Future<TSettings> loadSettings() async {
    // lava(bows[_settingsMap[_settingsKey]!.theme]);
    return fromHive(_settingsMap[_settingsKey]!);
  }
}
