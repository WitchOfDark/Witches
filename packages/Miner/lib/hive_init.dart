import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:tamannaah/darkknight/extensions/build_context.dart';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_constants.dart';

Future<void> hiveInit(List<int> myHiveConstants) async {
  if (kDebugMode) {
    for (var e in myHiveConstants) {
      if (globalHiveConstants.contains(e)) {
        throw Exception("Same constant on two hiveModels");
      }
    }
  }

  if (!Device.isWeb) {
    lava(await getApplicationSupportDirectory());
    Hive.init((await getApplicationSupportDirectory()).path);
  }
}
