import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

abstract class ToWidget {
  Widget toWidget();
}

abstract class ToMap {
  Map<String, Map> toMap();
}

abstract class DbHelp implements ToWidget, ToMap {}

abstract class Service {
  bool initialized = false;
  Future<void> init() async {}
}

abstract class DbService implements Service {
  Box<DbHelp>? get pbox;
  IsarCollection<DbHelp>? get ibox;
  HashMap<String, DbHelp>? get pmap;
}

class BlocService {
  final Service? service;

  //Probably no need to use Multirepository provider, access service only through bloc
  // final RepositoryProvider Function() serviceProvider;
  final BlocProvider Function() blocProvider;

  BlocService({
    this.service,
    // required this.serviceProvider,
    required this.blocProvider,
  });
}
