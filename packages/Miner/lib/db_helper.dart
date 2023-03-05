import 'dart:collection';

import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

import 'package:tamannaah/darkknight/bloc_service.dart';
import 'package:tamannaah/services/settings/settings_bloc.dart';

abstract class DbHelp implements ToWidget, ToMap {}

abstract class HDbService implements Service {
  Box<DbHelp>? get pbox;
  HashMap<String, DbHelp>? get pmap;
}

abstract class IDbService implements Service {
  IsarCollection<DbHelp>? get ibox;
  HashMap<String, DbHelp>? get pmap;
}

abstract class HDbSettingsService implements HDbService, SettingsService {}

abstract class IDbSettingsService implements IDbService, SettingsService {}
