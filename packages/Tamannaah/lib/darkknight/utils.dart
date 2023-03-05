import 'dart:math' show max, min, Random;

import 'package:crypto/crypto.dart';
import "dart:convert";

import 'package:flutter/material.dart';

import 'debug_functions.dart';

String md5sum(String text) {
  return md5.convert(utf8.encode(text)).toString();
}

//Casting is important
// ignore: unnecessary_cast
T? cast<T>(x) => x is T ? (x as T) : null;

// ignore: unnecessary_cast
T casti<T>(x, T v) => x is T ? (x as T) : v;

int? ci(dynamic x) => int.tryParse(x.toString());
double? cd(dynamic x) => double.tryParse(x.toString());
DateTime? cdate(dynamic x) => DateTime.tryParse(x.toString());

List<Map<String, dynamic>> clm(List<dynamic>? obj) {
  try {
    return obj?.map<Map<String, dynamic>>((e) => e.toMap()).toList() ?? [];
  } catch (e) {
    lava(e.toString());
    return [];
  }
}

List<T> clo<T>(List<dynamic>? obj, T Function(Map<String, dynamic>) fromMap) {
  try {
    return obj?.map<T>((x) => fromMap(x)).toList() ?? [];
  } catch (e) {
    lava(e.toString());
    return [];
  }
}

Map<String, dynamic> maptoJson(
  Map map, {
  bool removeNull = false,
  bool stringify = false,
  bool printType = false,
}) {
  return Map.fromEntries(
    map.entries.where((e) => removeNull ? (e.value != null) : true).map(
      (e) {
        return MapEntry(
          e.key,
          objToJson(e.value, stringify: stringify, printType: printType, removeNull: removeNull),
        );
      },
    ),
  );
}

/// Object : toString()
/// Map Object : toMap()
/// Primitive : int, String, double
/// Map
/// List
dynamic objToJson(
  dynamic obj, {
  bool stringify = false,
  bool printType = false,
  bool removeNull = false,
}) {
  if (obj is Map) {
    return maptoJson(obj, stringify: stringify, printType: printType, removeNull: removeNull);
  }

  if (obj is List) {
    return obj.map((o) => objToJson(o, stringify: stringify, printType: printType, removeNull: removeNull)).toList();
  }

  if (obj is int || obj is double || obj is String || obj == null) {
    if (printType) {
      return obj.runtimeType;
    }
    if (stringify) {
      return obj.toString();
    }
    return obj;
  }

  try {
    return maptoJson(obj.toMap(), stringify: stringify, printType: printType, removeNull: removeNull);
  } catch (exception) {
    lava(exception.toString());
    return obj.toString();
  }
}

@immutable
class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color random() {
    return Color(0xFF000000 + Random().nextInt(0xFFFFFF));
  }
}

extension Shade on Color {
  Color shade(int r, [int? g, int? b, int? a]) {
    g = g ?? r;
    b = b ?? r;
    a = a ?? 0;
    return Color.fromARGB(
      max(min(alpha + a, 255), 0),
      max(min(red + r, 255), 0),
      max(min(green + g, 255), 0),
      max(min(blue + b, 255), 0),
    );
  }

  Color grey(int lighten) {
    int oo = ((red + blue + green) ~/ 3) + lighten;
    return Color.fromARGB(alpha, oo, oo, oo);
  }

  Color get i {
    return Color.fromARGB(alpha, 255 - red, 255 - green, 255 - blue);
  }
}

String randomString(int length) {
  var result = '';
  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.characters.elementAt((Random().nextDouble() * charactersLength) ~/ 1);
  }
  return result;
}

String stringSting(String text) {
  String res = text.replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (Match m) => (' ${m.group(0)}'));
  String finalResult = res[0].toUpperCase() + res.substring(1);
  return finalResult;
}
