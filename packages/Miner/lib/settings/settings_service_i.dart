// import 'dart:collection';

// import 'package:darkknight/debug_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:isar/isar.dart';

// import '../db_helper.dart';

// @collection
// class IsarSettings implements DbHelp {
//   Id id = Isar.autoIncrement;
//   final int theme;
//   final int lastAppOpen;

//   IsarSettings({
//     required this.theme,
//     required this.lastAppOpen,
//   });

//   IsarSettings copyWith({
//     int? theme,
//     int? lastAppOpen,
//   }) {
//     return IsarSettings(
//       theme: theme ?? this.theme,
//       lastAppOpen: lastAppOpen ?? this.lastAppOpen,
//     );
//   }

//   @override
//   Widget toWidget() {
//     return Column(
//       children: [
//         Text("Theme : $theme"),
//         Text("Last Open : $lastAppOpen"),
//       ],
//     );
//   }

//   @override
//   Map<String, Map> toMap() {
//     return {
//       "Settings": {
//         'theme': theme,
//         'lastAppOpen': lastAppOpen,
//       }
//     };
//   }
// }

// class SettingsService implements IDbSettingsService {
//   @override
//   bool initialized = false;

//   IsarCollection<IsarSettings>? _isarSettingsBox;

//   @override
//   IsarCollection<IsarSettings>? get ibox {
//     return _isarSettingsBox;
//   }

//   final String _settingsKey = "Settings";

//   final HashMap<String, IsarSettings> _settingsMap = HashMap<String, IsarSettings>();

//   @override
//   HashMap<String, IsarSettings> get pmap {
//     return _settingsMap;
//   }

//   @override
//   Future<void> init() async {
//     if (!initialized) {
//       _isarSettingsBox = Isar.getInstance()?.collection<IsarSettings>();

//       int time = DateTime.now().millisecondsSinceEpoch;

//       IsarSettings s =
//           (await _isarSettingsBox?.get(1))?.copyWith(lastAppOpen: time) ?? IsarSettings(theme: 0, lastAppOpen: time);

//       await updateSettings(s);

//       // await _api.clear();
//     }
//     initialized = true;
//     dino("SettingsService initialized $initialized");
//   }

//   //updateSettings : update on memory and disk
//   Future<IsarSettings> updateSettings(IsarSettings s) async {
//     _settingsMap.update(_settingsKey, (value) => s, ifAbsent: () => s);
//     await _isarSettingsBox?.put(s);
//     return s;
//   }

//   Future<IsarSettings> loadSettings() async {
//     return _settingsMap[_settingsKey]!;
//   }
// }
